//
//  APICall.swift
//  Restaurant
//
//  Created by Alak on 12/01/21.
//

import Foundation

struct API {

  static let baseUrl = "https://restaurant-api.dicoding.dev/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case list
    case imageUrl
    
    public var url: String {
      switch self {
      case .list: return "\(API.baseUrl)list"
      case .imageUrl: return "\(API.baseUrl)images/medium/"
      }
    }
  }
  
}
