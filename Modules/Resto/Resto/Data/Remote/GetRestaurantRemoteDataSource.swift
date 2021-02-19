//
//  GetRestaurantRemoteDataSource.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import RestoCore
import Combine
import Alamofire

public struct GetRestaurantRemoteDataSource: DataSource {
    
    public typealias Request = String
    
    public typealias Response = RestaurantResponse
    
    private let _endpoint: String

    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<RestaurantResponse, Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest) )}
            
            if let url = URL(string: _endpoint + request ) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: RestaurantsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.restaurants[0]))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
