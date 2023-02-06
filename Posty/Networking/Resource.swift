//
//  Resource.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

public enum RequestMethod: String {
    case DELETE
    case GET
    case POST
    case PUT
    case HEAD
    case PATCH
}

public enum APIVersion: String {
    case v1 = "v1"
    case v2 = "v2"
    case v3 = "v3"
    case none = ""
}

public struct Resource {
    let path: URLConvertible
    var method: RequestMethod = .GET
    public var additionalHeaders: [String: String] = [:]
    public var requestBody: Data?
    public var queryItems: [URLQueryItem]?
    public var api: APIVersion = .none
}

public extension Resource {
    
    init(path: URLConvertible, method: RequestMethod = .GET) {
        self.path = path
        self.method = method
    }
    
    var debugDescription: String {
        return """
        -> [\(method.rawValue)] \(path.urlString())
        \(queryItems ?? [])
        \(String(describing: String(data: requestBody ?? Data(), encoding: .utf8)))
        """
    }
}

/// Used when HTTP response body is empty
public struct EmptyResponse: Codable { }
