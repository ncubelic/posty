//
//  NetworkManager.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

public protocol Networker {
    func apiCall(for resource: Resource, on queue: DispatchQueue, completion: @escaping (Result<Data, ErrorReport>) -> Void)
}

public class NetworkManager: Networker {
    
    typealias Failure = (ErrorReport) -> Void
    
    private(set) var configuration: NetworkConfiguration
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    public func apiCall(for resource: Resource, on queue: DispatchQueue = .main, completion: @escaping (Result<Data, ErrorReport>) -> Void) {
        guard let endpoint = createEndpoint(for: resource) else { return }
        var request = createURLRequest(from: resource, endpoint)
        let httpHeaders = getHttpHeaders(requiredHeaders: configuration.requiredHTTPHeaders, overrideExisting: resource.additionalHeaders)
        httpHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        print("-> " + configuration.baseURL.absoluteString)
        print(resource.debugDescription)
        let task = configuration.session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            let networkResponseState = self.getNetworkResponseState(response: response, error: error, data: data)
            
            switch networkResponseState {
            case NetworkResponseState.failure(let errorReport):
                queue.async {
                    completion(.failure(errorReport))
                }
            case NetworkResponseState.success:
                let responseResult: Result<Data, ErrorReport> = self.getResponseResult(data: data)
                
                queue.async {
                    completion(responseResult)
                }
            }
        }
        task.resume()
    }
    
    func createEndpoint(for resource: Resource) -> URL? {
        var components = URLComponents(url: configuration.baseURL, resolvingAgainstBaseURL: true)
        components?.path.append(resource.api.rawValue + resource.path.urlString())
        components?.queryItems = resource.queryItems
         return components?.url
    }
    
    func createURLRequest(from resource: Resource, _ endpoint: URL) -> URLRequest {
        let mutableRequest = NSMutableURLRequest(url: endpoint)
        mutableRequest.httpMethod = resource.method.rawValue
        mutableRequest.httpBody = resource.requestBody
        return mutableRequest as URLRequest
    }
    
    func getHttpHeaders(requiredHeaders: [String: String], overrideExisting additionalHeaders: [String: String]) -> [String: String] {
        var headers = requiredHeaders
        additionalHeaders.forEach { key, value in
            headers[key] = value
        }
        return headers
    }
    
    func getNetworkResponseState(response: URLResponse?, error: Error?, data: Data?) -> NetworkResponseState {
        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(ErrorReport(cause: .other, data: nil))
        }
        
//        guard !urlResponse.isAppOutdated() else {
//            return .failure(ErrorReport(cause: .appOutdated, data: nil))
//        }
        
        // Check for success status code
        guard 200...299 ~= urlResponse.statusCode else {
            let errorReport = processNotSuccessStatus(status: urlResponse.statusCode, data: data)
            return .failure(errorReport)
        }
        
        return .success
    }
    
    func processNotSuccessStatus(status: Int, data: Data?) -> ErrorReport {
        switch status {
        case 401:
            return ErrorReport(cause: .unauthorized, data: data)
        case 403:
            return ErrorReport(cause: .forbidden, data: data)
        case 404:
            return ErrorReport(cause: .resourceNotFound, data: data)
        case 400:
            return ErrorReport(cause: .badRequest, data: data)
        case 500:
            print("🆘 Error 500: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
            return ErrorReport(cause: .serverError, data: data)
        case 503:
            return ErrorReport(cause: .serviceUnavailable, data: data)
        default:
            return ErrorReport(cause: .other, data: data)
        }
    }
    
    func getResponseResult(data: Data?) -> Result<Data, ErrorReport> {
        // Check for response data
        guard let responseData = data else {
            return .failure(ErrorReport(cause: .other, data: nil))
        }

        return .success(responseData)
    }
}

internal enum NetworkResponseState {
    case success
    case failure(ErrorReport)
}

extension HTTPURLResponse {
    
    func value(forHTTPHeader httpHeaderField: String) -> String? {
        return allHeaderFields[httpHeaderField] as? String
    }
}
