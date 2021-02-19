//
//  ContentView.swift
//  Restaurant
//
//  Created by Alak on 20/12/20.
//

import SwiftUI
import RestoCore
import Resto

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<String, RestaurantDomainModel, Interactor<String, [RestaurantDomainModel], GetRestaurantsRepository<GetRestaurantLocaleDataSource, GetRestaurantsRemoteDataSource, RestaurantsTransformer<RestaurantTransformer>>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, RestaurantDomainModel, Interactor<String, [RestaurantDomainModel], GetFavoriteRestaurantRepository<GetFavoriteRestaurantsLocaleDataSource, RestaurantsTransformer<RestaurantTransformer>>>>

    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
