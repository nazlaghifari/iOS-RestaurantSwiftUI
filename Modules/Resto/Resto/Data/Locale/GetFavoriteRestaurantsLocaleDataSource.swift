//
//  GetFavoriteRestaurantsLocaleDataSource.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import Combine
import RealmSwift
import RestoCore

public struct GetFavoriteRestaurantsLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = RestaurantModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[RestaurantModuleEntity], Error> {
        return Future<[RestaurantModuleEntity], Error> { completion in
            let restaurantEntities = {
                _realm.objects(RestaurantModuleEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(restaurantEntities.toArray(ofType: RestaurantModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [RestaurantModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<RestaurantModuleEntity, Error> {
        return Future<RestaurantModuleEntity, Error> { completion in
            if let restaurantEntity = {
                _realm.objects(RestaurantModuleEntity.self)
                    .filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write {
                        restaurantEntity.setValue(!restaurantEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(restaurantEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: RestaurantModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
}
