//
//  SearchUseCaseMock.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix

final class SearchUseCaseMock: SearchUseCaseType {
    
    var getListMovieReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [Movie()]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    var loadMoreMovieCalled = false
    
    func loadMoreMovie(query: String, page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMovieCalled = true
        return getListMovieReturnValue
    }
}
