//
//  FavoriteUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol FavoriteUseCaseType {
    func getAllMovies() -> Observable<[Movie]>
    func delete(_ movie: Movie) -> Observable<Bool>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let repository: FavoriteRepositoryType
    
    func getAllMovies() -> Observable<[Movie]> {
        return repository.getAllMovies()
    }
    
    func delete(_ movie: Movie) -> Observable<Bool> {
        return repository.delete(movie)
    }
}
