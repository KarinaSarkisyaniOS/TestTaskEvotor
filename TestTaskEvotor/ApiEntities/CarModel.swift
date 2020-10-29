//
//  CarModel.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import Foundation

struct CarModel: Decodable {
    var brandId: String
    var name: String
    var releaseDate: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        brandId = try container.decode(String.self, forKey: .brandId)
        name = try container.decode(String.self, forKey: .name)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case brandId = "brand_id"
        case name = "modelName"
        case releaseDate = "releaseDate"
    }
}
