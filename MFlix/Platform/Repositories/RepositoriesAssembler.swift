//
//  RepositoriesAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/24/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol RepositoriesAssembler {
    func resolve() -> WatchNowRepositoryType
    func resolve() -> SeeAllRepositoryType
    func resolve() -> SearchRepositoryType
    func resolve() -> MovieDetailRepositoryType
    func resolve() -> FavoriteRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> WatchNowRepositoryType {
        return WatchNowRepository()
    }
    
    func resolve() -> SeeAllRepositoryType {
        return SeeAllRepository()
    }
    
    func resolve() -> SearchRepositoryType {
        return SearchRepository()
    }
    
    func resolve() -> MovieDetailRepositoryType {
        return MovieDetailRepository()
    }
    
    func resolve() -> FavoriteRepositoryType {
        return FavoriteRepository()
    }
}
