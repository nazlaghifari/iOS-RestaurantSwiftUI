//
//  RestaurantDomainModel.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation

public struct RestaurantDomainModel: Equatable, Identifiable {
    
    public let id: String
    public let name: String
    public var restaurantDescription: String = ""
    public let pictureId: String
    public var city: String = ""
    public var rating: Double = 0.0
    public var favorite: Bool = false
}
