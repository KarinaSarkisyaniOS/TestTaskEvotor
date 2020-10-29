//
//  Brand.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import Foundation

struct Brand: Decodable {
    var id: String
    var name: String
    var founders: [String]
    var foundationDate: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        founders = try container.decode([String].self, forKey: .founders)
        foundationDate = try container.decode(String.self, forKey: .foundationDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "brand_name"
        case founders = "founder_names"
        case foundationDate = "foundationDate"
    }
}
