//
//  RestaurantsResponse.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation

public struct RestaurantsResponse: Decodable {
    
    let restaurants: [RestaurantResponse]
    
}

public struct RestaurantResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case restaurantDescription = "description"
        case pictureId = "pictureId"
        case city = "city"
        case rating = "rating"
    }
    
    let id: String?
    let name: String?
    let restaurantDescription: String?
    let pictureId: String?
    let city: String?
    let rating: Double?
}
