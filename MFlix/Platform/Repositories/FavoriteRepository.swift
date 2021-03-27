//
//  FavoriteRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/20/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol FavoriteRepositoryType {
    func add(_ movie: Movie) -> Observable<Movie>
    func getAllMovies() -> Observable<[Movie]>
    func delete(_ movie: Movie) -> Observable<Bool>
    func checkExist(_ movie: Movie) -> Bool
}

struct FavoriteRepository: FavoriteRepositoryType {
    
    func add(_ movie: Movie) -> Observable<Movie> {
        return RealmManager.shared.addData(item: movie)
    }
    
    func getAllMovies() -> Observable<[Movie]> {
        let movies: Observable<[Movie]>  = RealmManager.shared.getAllData()
        return movies
    }
    
    func delete(_ movie: Movie) -> Observable<Bool> {
        return RealmManager.shared.deleteMovieData(item: movie)
    }
    
    func checkExist(_ movie: Movie) -> Bool {
        return RealmManager.shared.checkMovieExist(item: movie)
    }
}
