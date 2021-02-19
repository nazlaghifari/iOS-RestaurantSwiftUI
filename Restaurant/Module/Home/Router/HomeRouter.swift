//
//  HomeRouter.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import Foundation
import SwiftUI
import Resto
import RestoCore

class HomeRouter {
    
    func makeDetailView(for restaurant: RestaurantDomainModel) -> some View {
//        let useCase: Interactor<
//            String,
//            [RestaurantDomainModel],
//            GetRestaurantsRepository<
//                GetRestaurantLocaleDataSource,
//                GetRestaurantsRemoteDataSource,
//                RestaurantsTransformer<RestaurantTransformer>>> = Injection.init().provideRestaurants()
        let useCase: Interactor<
            String,
            RestaurantDomainModel,
            GetRestaurantRepository<
                GetRestaurantLocaleDataSource,
                GetRestaurantRemoteDataSource,
                RestaurantTransformer>> = Injection.init().provideRestaurant()

        let favoriteUseCase: Interactor<
            String,
            RestaurantDomainModel,
            UpdateFavoriteRestaurantRepository<
                GetFavoriteRestaurantsLocaleDataSource,
                RestaurantTransformer>> = Injection.init().provideUpdateFavorite()
        
        let presenter = RestaurantPresenter(restaurantUseCase: useCase, favoriteUseCase: favoriteUseCase)
//        let presenter = GetListPresenter(useCase: useCase)
        return DetailView(presenter: presenter, restaurant: restaurant)
    }
    
}
