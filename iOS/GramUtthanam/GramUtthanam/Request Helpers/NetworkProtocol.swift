//
//  NetworkProtocol.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation
import Alamofire

typealias URLParameters = [String: String]
typealias ResponseType = DataResponse<Any>

protocol BasePathProtocol {
    static var basePath: String { get }
}

protocol RequestProtocol {
    static var route: String { get }
}
extension RequestProtocol {
    
    static func createRequest(parameters: Parameters? = nil, urlParameters: URLParameters? = nil, method: HTTPMethod, encoding: URLEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> APIRequest {
        let apiRoute = fillParameters(params: urlParameters, inURLPath: route)
        return APIRequest(route: apiRoute, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    static func fillParameters(params: URLParameters?, inURLPath urlPath: String) -> String {
        guard let urlParameters = params  else { return urlPath }
        var apiRoute = urlPath
        for (key, value) in urlParameters {
            apiRoute = apiRoute.replacingOccurrences(of: "{{\(key)}}", with: value)
        }
        return apiRoute
    }
    
}
