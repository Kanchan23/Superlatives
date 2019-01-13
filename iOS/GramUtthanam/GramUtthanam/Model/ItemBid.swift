//
//  ItemBid.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/13/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Foundation

struct ItemBid: Decodable {
    let id: String
    let cropTypeID: String
    let quantity: Int
    let price: Int
    let address: String
    let userID: String
    let totalAmount: Int
    let creationDate: String
    let status: String
    let isCancelled: Bool
    let bidFlag: Bool
    let checkFlag: Bool

    
    private enum CodingKeys: String, CodingKey {
        
        case dataLayer1 = "created"
        case dataLayer2 = "result"
        case quantity, price, bidFlag, status, checkFlag
        case cropTypeID = "crop_category"
        case address = "pickup_location"
        case userID = "farmer_id"
        case id = "_id"
        case totalAmount = "total"
        case creationDate = "created_at"
        case isCancelled = "cancelFlag"
        
    }
    
    init(from decoder: Decoder) throws {
        let resultContainer = try decoder.container(keyedBy: CodingKeys.self)
//        let mainRes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .dataLayer1)
//        let resultContainer = try mainRes.nestedContainer(keyedBy: CodingKeys.self, forKey: .dataLayer2)
        
        id = try resultContainer.decode(String.self, forKey: .id)
        cropTypeID = try resultContainer.decode(String.self, forKey: .cropTypeID)
        quantity = try resultContainer.decode(Int.self, forKey: .quantity)
        price = try resultContainer.decode(Int.self, forKey: .price)
        address = try resultContainer.decode(String.self, forKey: .address)
        userID = try resultContainer.decode(String.self, forKey: .userID)
        totalAmount = try resultContainer.decode(Int.self, forKey: .totalAmount)
        creationDate = try resultContainer.decode(String.self, forKey: .creationDate)
        status = try resultContainer.decode(String.self, forKey: .status)
        isCancelled = try resultContainer.decode(Bool.self, forKey: .isCancelled)
        bidFlag = try resultContainer.decode(Bool.self, forKey: .bidFlag)
        checkFlag = try resultContainer.decode(Bool.self, forKey: .checkFlag)
    }
}
