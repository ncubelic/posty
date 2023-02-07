@testable import Posty
import XCTest

class NetworkManagerTests: XCTestCase {
    
    private let dummyURL = URL(string: "https://mock.hr")!
    
    func testThatNetworkConfigurationLoadsBasePathFromInfoPlist() {
        let config = NetworkConfiguration(baseURL: .baseURL)
        XCTAssertNotNil(config.baseURL)
        XCTAssertEqual(config.baseURL, URL(string: "https://jsonplaceholder.typicode.com")!)
    }
    
    func testThatNetworkConfigurationSetCustomBasePath() {
        let config = NetworkConfiguration(baseURL: dummyURL)
        XCTAssertNotNil(config.baseURL)
        XCTAssertEqual(config.baseURL, dummyURL)
    }
    
    func testThatNetworkManagerLoadsDefaultConfigurations() {
        
        let defaultHTTPHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let networkManager = NetworkManager(configuration: .default)
        
        XCTAssertEqual(networkManager.configuration.requiredHTTPHeaders, defaultHTTPHeaders)
    }
    
    func testThatNetworkManagerGetFailureWhenNetworkResponseIsFailure() {
        let networkState = failureResponseState()
        
        if case NetworkResponseState.success = networkState {
            XCTFail("Response state should be 'failure', not 'success'.")
        }
    }
    
    func testThatNetworkResponseStateIsSuccessWhenStatusCodeIsIn200Range() {
        let networkState = networkResponseState(forStatus: 200)
        
        if case NetworkResponseState.failure = networkState {
            XCTFail("Response state should be 'success', not 'failure'.")
        }
    }
    
    func testThatNetworkResponseStateIsFailureWhenStatusCodeIsNotIn200Range() {
        let networkState = networkResponseState(forStatus: 500)
        
        if case NetworkResponseState.success = networkState {
            XCTFail("Response state should be 'failure' not 'success'.")
        }
    }
    
    func successfulNetworkManager(withResponse data: Data) -> NetworkManager {
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        let config = NetworkConfiguration(baseURL: .baseURL, session: MockURLSession(data: data, response: response, error: nil))
        let networkManager = NetworkManager(configuration: config)
        
        return networkManager
    }
    
    func networkResponseState(forStatus status: Int) -> NetworkResponseState {
        let networkManager = NetworkManager(configuration: .default)
        let response = HTTPURLResponse(url: dummyURL, statusCode: status, httpVersion: nil, headerFields: nil)
        let networkState = networkManager.getNetworkResponseState(response: response, error: nil, data: nil)
        return networkState
    }
    
    func failureResponseState() -> NetworkResponseState {
        let networkManager = NetworkManager(configuration: .default)
        let networkState = networkManager.getNetworkResponseState(response: nil, error: nil, data: nil)
        return networkState
    }
}

// MARK: - Mock classes

extension NetworkManagerTests {
    
    final class MockURLSession: URLSession {
        
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
            super.init(configuration: .default)
        }
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            completionHandler(data, response, error)
            return MockDataTask()
        }
    }
    
    final class MockDataTask: URLSessionDataTask {
        
        override func resume() { }
    }
}
