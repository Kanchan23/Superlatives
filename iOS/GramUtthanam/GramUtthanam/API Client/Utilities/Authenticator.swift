//
//  Authenticator.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation

typealias JSONDict = [String: Any]

struct Authenticator {
    
    static private let invalidLoginError = "Provided credentials are invalid. Please re-enter and try again"
    
    static func login(parameters: JSONDict, completionHandler:  @escaping (User?, String?) -> Void) {
        Routes.Login.createRequest(parameters: parameters, method: .post).send { (response: User?, error: RequestError?) in
            guard response == nil  else { return completionHandler(response, nil) }
            let error = error ?? RequestError.response(error: RequestError.commonErrorMsg)
            switch error {
            case .authorization(_, _): completionHandler(nil, invalidLoginError)
            case .unexpectedFormat(let reason), .response(let reason): completionHandler(nil, reason)
            case .dataNotFound: completionHandler(nil, RequestError.commonErrorMsg)
            }
        }
    }
    
}
