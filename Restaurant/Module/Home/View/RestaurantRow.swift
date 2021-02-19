//
//  RestaurantRow.swift
//  Restaurant
//
//  Created by Alak on 22/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Resto
import RestoCore

struct RestaurantRow: View {
    
    var restaurant: RestaurantDomainModel
    
    var body: some View {
        VStack {
            imageRestaurant
            content
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding([.leading, .trailing, .top], 16)
    }
}

extension RestaurantRow {
    
    var imageRestaurant: some View {
        WebImage(url: URL(string: Endpoints.Gets.imageUrl.url + restaurant.pictureId))
            .resizable()
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: .zero, maxWidth: .infinity)
    }
    
    var content: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text(restaurant.city)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                Text(String(restaurant.rating))
            }
            .frame(width: 35, height: 35)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.orange))

        }.padding(16)

    }
}
