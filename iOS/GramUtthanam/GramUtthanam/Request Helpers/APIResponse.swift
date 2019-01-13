//
//  APIResponse.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation
import Alamofire

struct APIResponse {
    
    static func validate(response: ResponseType) throws {
        try checkForEmpty(response: response)
        try checkForServerError(response: response)
        guard response.result.error == nil  else { throw response.result.error! }
    }
    
    static private func checkForEmpty(response: ResponseType) throws {
        guard let responseData = response.data,
            let jsonDict = try? JSONDecoder().decode([String: String].self, from: responseData),
            jsonDict.count == 0
            else { return }
        throw RequestError.dataNotFound
    }
    
    static private func checkForServerError(response: ResponseType) throws {
        guard response.response?.statusCode == RequestError.serverErrorCode  else { return }
        throw RequestError.authorization(code: RequestError.serverErrorCode, msg: RequestError.commonErrorMsg)
    }
    
}
