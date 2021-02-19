//
//  FavoriteRow.swift
//  Restaurant
//
//  Created by Alak on 12/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Resto

struct FavoriteRow: View {
    var restaurant: RestaurantDomainModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                imageRestaurant
                content
            }
            .padding([.leading, .trailing, .top], 16)
            Divider()
              .padding([.leading, .trailing])
        }
    }
}

extension FavoriteRow {
    
    var imageRestaurant: some View {
        WebImage(url: URL(string: Endpoints.Gets.imageUrl.url + restaurant.pictureId))
            .resizable()
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .renderingMode(.original)
            .scaledToFill()
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            .padding(.trailing, 8)
    }
    
    var content: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurant.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                HStack {
                    Text(restaurant.city)
                        .font(.subheadline)
                    Spacer()
                    HStack(spacing: 10) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(String(restaurant.rating))
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.orange))
                }
            }
        }
        .padding([.bottom, .top], 16)
    }
}
