//
//  FavoriteView.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import SwiftUI
import Foundation
import RestoCore
import Resto

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, RestaurantDomainModel, Interactor<String, [RestaurantDomainModel], GetFavoriteRestaurantRepository<GetFavoriteRestaurantsLocaleDataSource, RestaurantsTransformer<RestaurantTransformer>>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    ProgressView()
                }
            } else if presenter.isError {
                VStack {
                    Text("Error!")
                }
            } else if presenter.list.count == 0 {
                VStack {
                    Text("No Favorite Restaurant")
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.list,
                            id: \.id
                        ) { restaurant in
                            ZStack {
                                linkBuilder(for: restaurant) {
                                    FavoriteRow(restaurant: restaurant)
                                }.buttonStyle(PlainButtonStyle())
                            }
                            
                        }
                }
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Favorite"),
            displayMode: .automatic
        )
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: restaurant)
        ) { content() }
    }
}
