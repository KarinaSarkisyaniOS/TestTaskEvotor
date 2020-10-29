//
//  ApiRequests.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import Alamofire

enum ApiRequest {
    case getBrands
    case getCarModels
    
    var url: URL {
        get {
            switch self {
            case .getBrands:
                return URL(string: "http://www.mocky.io/v2/5db959e43000005a005ee206")!
            case .getCarModels:
                return URL(string: "http://www.mocky.io/v2/5db9630530000095005ee272")!
            }
        }
    }
    
    var method: Alamofire.HTTPMethod {
        get {
            switch self {
            case .getBrands: return .post
            case .getCarModels: return .get
            }
        }
    }
    
}
