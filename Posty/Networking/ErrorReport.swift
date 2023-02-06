//
//  ErrorReport.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

public struct ErrorReport: Error {
    var cause: Cause
    var data: Data?
    
    public init(cause: Cause, data: Data?) {
        self.cause = cause
        self.data = data
    }
}
