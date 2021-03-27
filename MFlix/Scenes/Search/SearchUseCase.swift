//
//  SearchUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchUseCaseType {
    func loadMoreMovie(query: String, page: Int) -> Observable<PagingInfo<Movie>>
}

struct SearchUseCase: SearchUseCaseType {

    let repository: SearchRepositoryType
    
    func loadMoreMovie(query: String, page: Int) -> Observable<PagingInfo<Movie>> {
        if query.isEmpty {
            let emptyPage = PagingInfo<Movie>(page: 1, items: [])
            return Observable<PagingInfo<Movie>>.just(emptyPage)
        }
        let request = SearchRequest(query: query, page: page)
        return repository.searchMovieList(input: request)
    }
}
