//
//  NetworkConfiguration.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

public class NetworkConfiguration {
    
    private(set) var baseURL: URL
    private(set) var requiredHTTPHeaders: [String: String]
    private(set) var session: URLSession
    
    public init(baseURL: URL, requiredHTTPHeaders: [String: String] = [:], session: URLSession = .shared) {
        self.baseURL = baseURL
        self.requiredHTTPHeaders = requiredHTTPHeaders
        self.session = session
        session.configuration.timeoutIntervalForRequest = 30
    }
    
    /// Adds new HTTP header to the requiredHeaders dictionary
    /// If key exists, it will be overwriten with new value
    public func addRequiredHTTPHeader(value: String, forKey: String) {
        self.requiredHTTPHeaders[forKey] = value
    }
    
    /// Removes all values from requredHTTPHeaders dictionary
    /// Adds all headers which are required in all requests
    public func resetRequiredHTTPHeaders() {
        self.requiredHTTPHeaders.removeAll()
    }
}

public extension NetworkConfiguration {
    
    static var `default`: NetworkConfiguration {
        .init(baseURL: .baseURL, requiredHTTPHeaders: .defaultHTTPHeaders)
    }
}

extension Dictionary {
    
    static var defaultHTTPHeaders: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}
