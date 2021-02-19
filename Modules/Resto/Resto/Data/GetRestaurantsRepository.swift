//
//  GetRestaurantsRepository.swift
//  Resto
//
//  Created by Alak on 15/02/21.
//

import Foundation
import Combine
import RestoCore

public struct GetRestaurantsRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
RestaurantLocaleDataSource.Request == String,
    RestaurantLocaleDataSource.Response == RestaurantModuleEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [RestaurantResponse],
    Transformer.Request == String,
    Transformer.Response == [RestaurantResponse],
    Transformer.Entity == [RestaurantModuleEntity],
    Transformer.Domain == [RestaurantDomainModel] {
    
    public typealias Request = String
    public typealias Response = [RestaurantDomainModel]
    
    private let _localeDataSource: RestaurantLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: RestaurantLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[RestaurantDomainModel], Error> {
        return _localeDataSource.list(request: request)
          .flatMap { result -> AnyPublisher<[RestaurantDomainModel], Error> in
            if result.isEmpty {
                return _remoteDataSource.execute(request: request)
                    .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                    .catch { _ in _localeDataSource.list(request: request) }
                    .flatMap {  _localeDataSource.add(entities: $0) }
                .filter { $0 }
                    .flatMap { _ in _localeDataSource.list(request: request)
                        .map {  _mapper.transformEntityToDomain(entity: $0) }
                }.eraseToAnyPublisher()
            } else {
                return _localeDataSource.list(request: request)
                    .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
    
}
