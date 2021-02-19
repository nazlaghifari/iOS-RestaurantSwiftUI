//
//  DetailView.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import RestoCore
import Resto

struct DetailView: View {
    
    @ObservedObject var presenter: RestaurantPresenter<
        Interactor<String, RestaurantDomainModel, GetRestaurantRepository<GetRestaurantLocaleDataSource, GetRestaurantRemoteDataSource, RestaurantTransformer>>,
        Interactor<String, RestaurantDomainModel, UpdateFavoriteRestaurantRepository<GetFavoriteRestaurantsLocaleDataSource, RestaurantTransformer>>>
    
    var restaurant: RestaurantDomainModel
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageRestaurant
                        content
                        Spacer()
                    }.padding()
                }
            }
        }
        .onAppear {
            if self.presenter.item == nil {
                self.presenter.getRestaurant(request: restaurant.id)
            }
        }
        .navigationTitle(presenter.item?.name ?? "")
    }
}

extension DetailView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
        }
    }
    
    var imageRestaurant: some View {
        WebImage(url: URL(string: Endpoints.Gets.imageUrl.url + self.presenter.item!.pictureId ))
            .resizable()
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: .zero, maxWidth: .infinity)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("City :")
                    .font(.system(size: 16, weight: .bold, design: .default))
                Text(presenter.item?.city ?? "")
                Spacer()
                if presenter.item?.favorite == true {
                    FavoriteIcon(imageName: "heart.fill")
                        .onTapGesture { self.presenter.updateFavoriteRestaurant(request: restaurant.id) }
                } else {
                    FavoriteIcon(imageName: "heart")
                        .onTapGesture { self.presenter.updateFavoriteRestaurant(request: restaurant.id) }
                }
            }
            HStack(alignment: .center) {
                Text("Rating :")
                    .font(.system(size: 16, weight: .bold, design: .default))
                HStack(spacing: 10) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(String(presenter.item?.rating ?? 0.0))
                }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(lineWidth: 1)
                .foregroundColor(.orange))
            }
            VStack(alignment: .leading) {
                Text("Description : ")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(.bottom, 2)
                Text(presenter.item?.restaurantDescription ?? "")
                    .font(.system(size: 16))
            }
        }
    }
}

struct FavoriteIcon: View {

    var imageName: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .foregroundColor(.red)
                .padding(.all, 10)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius : 8)
        }
    }
}
