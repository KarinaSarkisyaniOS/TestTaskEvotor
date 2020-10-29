//
//  ApiService.swift
//  TestTaskEvotor
//
//  Created by Karina Sarkisyan on 29.10.2020.
//

import Alamofire

final class ApiService {
    
    func send<T>(request: ApiRequest, handler: @escaping (DataResponse<T>?, String?) -> ()) where T: Decodable {
        AF
            .request(request.url, method: request.method)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            handler(nil, "Неизвестная ошибка")
                            return
                        }
                        let parsedResponse = try JSONDecoder().decode(DataResponse<T>.self, from: data)
                        handler(parsedResponse, nil)
                    } catch {
                        handler(nil, error.localizedDescription)
                    }
                case .failure(let error):
                    handler(nil, error.localizedDescription)
                }
            }
    }
}
