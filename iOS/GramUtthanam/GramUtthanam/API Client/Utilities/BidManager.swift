//
//  BidManager.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation

struct BidManager {
    
    static func createBid(parameters: JSONDict, completionHandler:  @escaping (ItemBid?, String?) -> Void) {
        Routes.CreateBid.createRequest(parameters: parameters, method: .post).send { (response: ItemBid?, error: RequestError?) in
            self.handleAPIResponse(response, error: error, completionHandler: completionHandler)
        }
    }
    
    static private func handleAPIResponse(_ response: ItemBid?, error: RequestError?, completionHandler: @escaping (ItemBid?, String?) -> Void) {
        guard response == nil else { return completionHandler(response, nil) }
        completionHandler(nil, RequestError.commonErrorMsg)
    }
    
    static func requestBids(completionHandler:  @escaping ([ItemBid]?, String?) -> Void) {
        Routes.Bids.createRequest(method: .get).send { (myBids: [ItemBid]?, error) in
            guard myBids == nil  else { return completionHandler(myBids, nil) }
            completionHandler(nil, RequestError.commonErrorMsg)
        }
    }
    
}
