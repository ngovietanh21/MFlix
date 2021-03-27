//
//  WatchNowUseCaseMock.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix

final class WatchNowUseCaseMock: WatchNowUseCaseType {
    
    var getMovieListReturnValue: Observable<[Movie]> = {
        return Observable.just([Movie]())
    }()
    
    var mergeItemsReturnValue: [WatchNowCellType] = {
        return [WatchNowCellType]()
    }()
    
    //MARK: - get Upcoming
    var getUpcomingCalled = false
    
    func getUpcomingMovies() -> Observable<[Movie]> {
        getUpcomingCalled = true
        return getMovieListReturnValue
    }
    
    //MARK: - get TopRated
    var getTopRatedCalled = false
    
    func getTopRatedMovies() -> Observable<[Movie]> {
        getTopRatedCalled = true
        return getMovieListReturnValue
    }
    
    //MARK: - get Popular
    var getPopularCalled = false
    
    func getPopularMovies() -> Observable<[Movie]> {
        getPopularCalled = true
        return getMovieListReturnValue
    }
    
    //MARK: - get NowPlaying
    var getNowPlayingCalled = false
    
    func getNowPlayingMovies() -> Observable<[Movie]> {
        getNowPlayingCalled = true
        return getMovieListReturnValue
    }
    
    //MARK: - MergerItems
    var mergeItemsCalled = false
    
    func mergeItems(nowPlayingMovies: [Movie], topRatedMovies: [Movie], popularMovies: [Movie], upcomingMovies: [Movie]) -> [WatchNowCellType] {
        mergeItemsCalled = true
        return mergeItemsReturnValue
    }
}
