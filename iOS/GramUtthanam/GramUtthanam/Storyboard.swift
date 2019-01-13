//
//  Storyboard.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import UIKit

protocol StoryboardProtocol {
    static var name: String { get }
}
extension StoryboardProtocol where Self: RawRepresentable, Self.RawValue == String {
    
    static private var instance: UIStoryboard { return UIStoryboard(name: name, bundle: nil) }
    var scene: UIViewController { return Self.instance.instantiateViewController(withIdentifier: rawValue)  }
    
}

enum MainStoryboard: String, StoryboardProtocol {
    static let name = "Main"
    
    case login = "LoginViewController"
}

