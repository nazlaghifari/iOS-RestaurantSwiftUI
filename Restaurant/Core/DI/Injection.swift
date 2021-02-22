//
//  Injection.swift
//  Restaurant
//
//  Created by Alak on 20/12/20.
//

import Foundation
import UIKit
import RealmSwift
import RestoCore
import Resto

final class Injection: NSObject {
    
    func provideRestaurants<U: UseCase>() -> U where U.Request == String, U.Response == [RestaurantDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetRestaurantLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetRestaurantsRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let restaurantMapper = RestaurantTransformer()
        let mapper = RestaurantsTransformer(restaurantMapper: restaurantMapper)
        let repository = GetRestaurantsRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideRestaurant<U: UseCase>() -> U where U.Request == String, U.Response == RestaurantDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetRestaurantLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetRestaurantRemoteDataSource(endpoint: Endpoints.Gets.list.url)
        
        let mapper = RestaurantTransformer()
        let repository = GetRestaurantRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [RestaurantDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetFavoriteRestaurantsLocaleDataSource(realm: appDelegate.realm)
        
        let restaurantMapper = RestaurantTransformer()
        let mapper = RestaurantsTransformer(restaurantMapper: restaurantMapper)
        
        let repository = GetFavoriteRestaurantRepository(
            localeDataSource: locale,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == RestaurantDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetFavoriteRestaurantsLocaleDataSource(realm: appDelegate.realm)
        
        let restaurantMapper = RestaurantTransformer()

        let repository = UpdateFavoriteRestaurantRepository(
            localeDataSource: locale,
            mapper: restaurantMapper)
        return Interactor(repository: repository) as! U
    }
}
