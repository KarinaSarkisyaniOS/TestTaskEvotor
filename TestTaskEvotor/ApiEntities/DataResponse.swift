//
//  DataResponse.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import Foundation

struct DataResponse<Entity>: Decodable where Entity: Decodable {
    var result: Int
    var data: [Entity]
}
