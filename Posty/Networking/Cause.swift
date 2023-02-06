//
//  Cause.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

public enum Cause {
    case noData
    case unauthorized
    case forbidden
    case appOutdated
    case serverError
    case serviceUnavailable
    case badRequest
    case other
    case resourceNotFound
}

extension Cause: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No response data"
        case .unauthorized:
            return "401 - Unauthorized"
        case .serviceUnavailable:
            return "503 - Service temporarily unavailable"
        case .resourceNotFound:
            return "404 - Resource not found"
        case .serverError:
            return "500 - Internal Server error"
        case .badRequest:
            return "400 - Bad request"
        case .forbidden:
            return "403 - Forbidden"
        default:
            return nil
        }
    }
}
