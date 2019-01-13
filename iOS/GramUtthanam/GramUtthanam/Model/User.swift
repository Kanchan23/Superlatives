//
//  User.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation

class User: Decodable {
    
    let token: String
    
}

extension User {
    
    static private(set) var instance: User?
    
//    func logout() {
//        UserCache.set(key: token, value: nil)
//        UserCache.userToken.value = nil
//        User.instance = nil
//    }

}
