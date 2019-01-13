//
//  RequestError.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation

enum RequestError: Error {
    case authorization(code: Int, msg: String)
    case unexpectedFormat(error: String)
    case response(error: String)
    case dataNotFound
    
    static let commonErrorMsg = "Something went wrong. Please try again later"
    static let serverErrorCode = 401
}
