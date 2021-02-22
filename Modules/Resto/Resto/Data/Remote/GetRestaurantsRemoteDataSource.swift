//
//  GetRestaurantsRemoteDataSource.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import RestoCore
import Combine
import Alamofire

public struct GetRestaurantsRemoteDataSource: DataSource {
    
    public typealias Request = String
    
    public typealias Response = [RestaurantResponse]
    
    private let _endpoint: String

    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<[RestaurantResponse], Error> { completion in
            
            if let url = URL(string: _endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.restaurants))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
