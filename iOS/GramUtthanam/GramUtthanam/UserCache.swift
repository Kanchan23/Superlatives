//
//  UserDefaults.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Foundation

enum UserCache: String {
    
    static private var userDefaults: UserDefaults { return UserDefaults.standard }
    
    case userToken = "Authorization"
}

extension UserCache {
    
    var value: Any? {
        get {
            return UserCache.value(forKey: rawValue)
        }
        nonmutating set(newValue) {
            UserCache.set(key: rawValue, value: newValue)
        }
    }
    
    var string: String? {
        return value as? String
    }
    
    static func value(forKey key: String) -> Any? {
        return userDefaults.value(forKey: key)
    }
    
    static func set(key: String, value: Any?) {
        guard value != nil  else { return userDefaults.removeObject(forKey: key) }
        userDefaults.set(value, forKey: key)
    }
    
}
