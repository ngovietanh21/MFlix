//
//  WatchNowUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowUseCaseType {
    func getUpcomingMovies() -> Observable<[Movie]>
    func getTopRatedMovies() -> Observable<[Movie]>
    func getPopularMovies() -> Observable<[Movie]>
    func getNowPlayingMovies() -> Observable<[Movie]>
    func mergeItems(nowPlayingMovies: [Movie],
                    topRatedMovies: [Movie],
                    popularMovies: [Movie],
                    upcomingMovies: [Movie]) -> [WatchNowCellType]
}

struct WatchNowUseCase: WatchNowUseCaseType {
    
    let repository: WatchNowRepositoryType
    
    func getUpcomingMovies() -> Observable<[Movie]> {
        let request = CategoryRequest(category: .upcoming)
        return repository.getMovieList(input: request)
    }
    
    func getTopRatedMovies() -> Observable<[Movie]> {
        let request = CategoryRequest(category: .topRated)
        return repository.getMovieList(input: request)
    }
    
    func getPopularMovies() -> Observable<[Movie]> {
        let request = CategoryRequest(category: .popular)
        return repository.getMovieList(input: request)
    }
    
    func getNowPlayingMovies() -> Observable<[Movie]> {
        let request = CategoryRequest(category: .nowPlaying)
        return repository.getMovieList(input: request)
    }
    
    func mergeItems(nowPlayingMovies: [Movie],
                    topRatedMovies: [Movie],
                    popularMovies: [Movie],
                    upcomingMovies: [Movie]) -> [WatchNowCellType] {
        
        let nowPlayingMovies = WatchNowCellType(category: .nowPlaying,
                                                movies: nowPlayingMovies)
    
        let topRatedMovies = WatchNowCellType(category: .topRated,
                                               movies: topRatedMovies)
        
        let popularMovies = WatchNowCellType(category: .popular,
                                             movies: popularMovies)
        
        let upcomingMovies = WatchNowCellType(category: .upcoming,
                                              movies: upcomingMovies)
        
        return [nowPlayingMovies, topRatedMovies, popularMovies, upcomingMovies]
    }
}
