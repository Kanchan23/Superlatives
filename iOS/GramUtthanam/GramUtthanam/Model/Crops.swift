//
//  Crops.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//


import Foundation

struct CropCategory: Decodable {

    let id: String
    let name: String

}

extension CropCategory {
    
    static let availableCropTypes: [CropCategory] = {
       return requestData()
    }()
    
    private static let jsonFileName = "CropTypes"
    private static func requestFromJSON() -> [CropCategory] {
        if let filepath = Bundle.main.path(forResource: jsonFileName, ofType: Constants.jsonFileExtension) {
            do {
                return try [CropCategory].init(fromURL: URL(fileURLWithPath: filepath))
            } catch let error {
                print("Problem with parsing Questionnaire file: \(error)")
            }
        }
        print("Questions file Not Found")
        return []
    }
    
    static func requestData() -> [CropCategory] {
        return requestFromJSON()
    }
    
}



// MARK: Convenience initializers
extension Array where Element == CropCategory {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode([CropCategory].self, from: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
}
