//
//  RestaurantsTransformer.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import RestoCore

public struct RestaurantsTransformer<RestaurantMapper: Mapper>: Mapper
where
    RestaurantMapper.Request == String,
    RestaurantMapper.Response == RestaurantResponse,
    RestaurantMapper.Entity == RestaurantModuleEntity,
    RestaurantMapper.Domain == RestaurantDomainModel {
    
    public typealias Request = String
    public typealias Response = [RestaurantResponse]
    public typealias Entity = [RestaurantModuleEntity]
    public typealias Domain = [RestaurantDomainModel]
    
    private let _restaurantMapper: RestaurantMapper
    
    public init(restaurantMapper: RestaurantMapper) {
        _restaurantMapper = restaurantMapper
    }
    
    public func transformResponseToEntity(request: String?, response: [RestaurantResponse]) -> [RestaurantModuleEntity] {
        return response.map { result in
            _restaurantMapper.transformResponseToEntity(request: request, response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [RestaurantModuleEntity]) -> [RestaurantDomainModel] {
        return entity.map { result in
            return _restaurantMapper.transformEntityToDomain(entity: result)
        }
    }
    
}
