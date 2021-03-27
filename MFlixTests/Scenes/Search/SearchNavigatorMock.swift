//
//  SearchNavigatorMock.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix

final class SearchNavigatorMock: SearchNavigatorType {
    
    var toMovieDetailCalled = false
    
    func toMovieDetailScreen(movie: Movie) {
        toMovieDetailCalled = true
    }
}
