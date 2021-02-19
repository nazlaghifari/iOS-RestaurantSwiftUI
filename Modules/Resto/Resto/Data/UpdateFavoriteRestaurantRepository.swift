//
//  UpdateFavoriteRestaurantRepository.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import Combine
import RestoCore

public struct UpdateFavoriteRestaurantRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Request == String,
    RestaurantLocaleDataSource.Response == RestaurantModuleEntity,
    Transformer.Request == String,
    Transformer.Response == RestaurantResponse,
    Transformer.Entity == RestaurantModuleEntity,
    Transformer.Domain == RestaurantDomainModel {
    
    public typealias Request = String
    public typealias Response = RestaurantDomainModel
    
    private let _localeDataSource: RestaurantLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: RestaurantLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<RestaurantDomainModel, Error> {
        return _localeDataSource.get(id: request ?? "")
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }

}
