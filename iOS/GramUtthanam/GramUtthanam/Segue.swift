//
//  Segue.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import UIKit

enum Segue: String {
    
    case mainApp = "mainAppSegue"
    case createBid = "createBidSegue"
    
}

func ==(lhs: Segue, rhs: UIStoryboardSegue) -> Bool {
    return lhs.rawValue == rhs.identifier
}

func ==(lhs: UIStoryboardSegue, rhs: Segue) -> Bool {
    return lhs.identifier == rhs.rawValue
}

func ==(lhs: Segue, rhs: String) -> Bool {
    return lhs.rawValue == rhs
}

func ==(lhs: String, rhs: Segue) -> Bool {
    return lhs == rhs.rawValue
}


