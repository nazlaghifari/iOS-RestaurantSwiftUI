//
//  RestaurantModuleEntity.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import RealmSwift

public class RestaurantModuleEntity: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var restaurantDescription = ""
    @objc dynamic var pictureId = ""
    @objc dynamic var city = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var favorite = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
