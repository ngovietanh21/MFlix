//
//  WatchNowNavigatorMock.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix

final class WatchNowNavigatorMock: WatchNowNavigatorType {
    
    //MARK: - To MovieDetail
    var toMovieDetailCalled = false
    
    func toMovieDetailScreen(movie: Movie) {
        toMovieDetailCalled = true
    }
    
    //MARK: - To SeeAll
    var toSeeAllScreenCalled = false
    
    func toSeeAllScreen(category: CategoryType) {
        toSeeAllScreenCalled = true
    }
}
