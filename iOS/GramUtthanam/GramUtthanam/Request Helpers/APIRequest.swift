//
//  APIRequest.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation
import Alamofire

struct APIRequest: URLRequestConvertible {
    
    let route: String
    let method: HTTPMethod
    let headers: HTTPHeaders
    let parameters: Parameters?
    let encoding: URLEncoding
    
    static private var defaultHeaders: HTTPHeaders {
        guard let userToken = UserCache.userToken.string  else { return [:] }
        return [UserCache.userToken.rawValue: "Bearer \(userToken)"]
    }
    
    init(route: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: URLEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) {
        
        self.route = route
        self.method = method
        self.parameters = parameters
        self.headers = (headers ?? [:]).add(dict: APIRequest.defaultHeaders)
        self.encoding = encoding
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try route.asURL()
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        for (key,value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRequest {
    
    func send(completionHandler: ((Error?) -> ())? = nil) {
        Alamofire.request(self).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success(_): completionHandler?(nil)
            case .failure(let error): completionHandler?(error)
            }
        }
    }
    
    func send<T: Decodable>(responseHandler: @escaping (T?, RequestError?) -> ()) {
        Alamofire.request(self).responseJSON { (response: ResponseType) in
            do {
                try APIResponse.validate(response: response)
                
                if T.self == ItemBid.self,
                   let response = response.result.value as? [String: Any],
                    let mainResult = response["result"] as? [String: Any] {
                    let jsonData = try JSONSerialization.data(withJSONObject: mainResult, options: [.prettyPrinted])
                    responseHandler(try T(data: jsonData), nil)
                } else {
                    guard let responseData = response.data  else { throw RequestError.dataNotFound }
                    responseHandler(try T(data: responseData), nil)
                }
            } catch {
                print(error)
                if error is URLError {
                    responseHandler(nil, RequestError.response(error: error.localizedDescription))
                } else if let err = error as? RequestError {
                    responseHandler(nil, err)
                } else {
                    responseHandler(nil, RequestError.unexpectedFormat(error: RequestError.commonErrorMsg))
                }
            }
        }
    }
    
}
