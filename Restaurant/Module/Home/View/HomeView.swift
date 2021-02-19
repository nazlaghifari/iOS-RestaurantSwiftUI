//
//  HomeView.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import SwiftUI
import Resto
import RestoCore
import Foundation

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, RestaurantDomainModel, Interactor<String, [RestaurantDomainModel], GetRestaurantsRepository<GetRestaurantLocaleDataSource, GetRestaurantsRemoteDataSource, RestaurantsTransformer<RestaurantTransformer>>>>
    @Namespace var namespace
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else {
                content
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }.navigationTitle("Restaurant")
    }
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
        }
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TextField("Search", text: $searchText)
                .font(.title3)
                .padding(8)
                .background(Color(#colorLiteral(red: 0.9645187259, green: 0.9649179578, blue: 0.9559617639, alpha: 1)))
                .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding()
            ForEach(
                self.presenter.list,
                id: \.id
            ) { restaurant in
                if restaurant.name.localizedCaseInsensitiveContains(searchText) || searchText == "" {
                    VStack {
                        linkBuilder(for: restaurant) {
                            RestaurantRow(restaurant: restaurant)
                        }
                    }
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: restaurant)) { content() }
    }
}
