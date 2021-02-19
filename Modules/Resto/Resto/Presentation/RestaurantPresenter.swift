//
//  RestaurantPresenter.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import Combine
import RestoCore

public class RestaurantPresenter<RestaurantUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    RestaurantUseCase.Request == String,
    RestaurantUseCase.Response == RestaurantDomainModel,
    FavoriteUseCase.Request == String,
    FavoriteUseCase.Response == RestaurantDomainModel {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _restaurantUseCase: RestaurantUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var item: RestaurantDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(restaurantUseCase: RestaurantUseCase, favoriteUseCase: FavoriteUseCase) {
        _restaurantUseCase = restaurantUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getRestaurant(request: RestaurantUseCase.Request) {
        isLoading = true
        _restaurantUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteRestaurant(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
}
