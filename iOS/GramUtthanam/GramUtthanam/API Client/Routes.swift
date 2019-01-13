//
//  APIRoutes.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Foundation

enum AppBaseRoutes: String {
    case production = ""
    case staging = "https://gramuthanam.herokuapp.com"
}

struct Routes: BasePathProtocol {
    
    static var basePath: String {  return AppBaseRoutes.staging.rawValue }

    public struct Login: RequestProtocol {
        static var route: String { return "\(basePath)/farmer/login" }
    }
    
    public struct Logout: RequestProtocol {
        static var route: String { return "\(basePath)/farmer/logout" }
    }

    public struct Bids: RequestProtocol {
        static var route: String { return "\(basePath)/cropBid/farmerBids" }
    }
    
    public struct CreateBid: RequestProtocol {
        static var route: String { return "\(basePath)/cropBid" }
    }

}

