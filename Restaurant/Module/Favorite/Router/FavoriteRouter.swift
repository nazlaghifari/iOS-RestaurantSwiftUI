//
//  FavoriteRouter.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import Foundation
import SwiftUI
import RestoCore
import Resto

class FavoriteRouter {
    
    func makeDetailView(for restaurant: RestaurantDomainModel) -> some View {
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
        
        return DetailView(presenter: presenter, restaurant: restaurant)
    }
}
