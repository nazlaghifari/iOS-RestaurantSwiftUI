//
//  RestaurantTransformer.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import RestoCore
import RealmSwift

public struct RestaurantTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = RestaurantResponse
    public typealias Entity = RestaurantModuleEntity
    public typealias Domain = RestaurantDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: RestaurantResponse) -> RestaurantModuleEntity {
        let resto = RestaurantModuleEntity()
        
        resto.id = response.id ?? ""
        resto.name = response.name ?? ""
        resto.restaurantDescription = response.restaurantDescription ?? ""
        resto.pictureId = response.pictureId ?? ""
        resto.city = response.city ?? ""
        resto.rating = response.rating ?? 0
        return resto
        
    }
    
    public func transformEntityToDomain(entity: RestaurantModuleEntity) -> RestaurantDomainModel {
        return RestaurantDomainModel(
            id: entity.id,
            name: entity.name,
            restaurantDescription: entity.restaurantDescription,
            pictureId: entity.pictureId,
            city: entity.city,
            rating: entity.rating,
            favorite: entity.favorite)
    }
}
