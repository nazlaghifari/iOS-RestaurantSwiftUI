//
//  GetRestaurantsLocaleDataSource.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import Combine
import RestoCore
import RealmSwift

public struct GetRestaurantLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    public typealias Response = RestaurantModuleEntity
    
    private let _realm: Realm

    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[RestaurantModuleEntity], Error> {
        return Future<[RestaurantModuleEntity], Error> { completion in
            let restaurants: Results<RestaurantModuleEntity> = {
                _realm.objects(RestaurantModuleEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(restaurants.toArray(ofType: RestaurantModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [RestaurantModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for restaurant in entities {
                        _realm.add(restaurant, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<RestaurantModuleEntity, Error> {
        return Future<RestaurantModuleEntity, Error> { completion in

            let restaurants: Results<RestaurantModuleEntity> = {
                _realm.objects(RestaurantModuleEntity.self)
                    .filter("id = '\(id)'")
            }()
            
            guard let restaurant = restaurants.first else {
                completion(.failure(DatabaseError.requestFailed))
                return
            }
            
            completion(.success(restaurant))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: RestaurantModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let restaurantEntity = {
                _realm.objects(RestaurantModuleEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write {
                        restaurantEntity.setValue(entity.favorite, forKey: "favorite")
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}
