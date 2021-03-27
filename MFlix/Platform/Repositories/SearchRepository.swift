//
//  SearchRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchRepositoryType {
    func searchMovieList(input: SearchRequest) -> Observable<PagingInfo<Movie>>
}

final class SearchRepository: SearchRepositoryType {

    private let api: APIService = APIService.share
    
    func searchMovieList(input: SearchRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map { (response: SearchResponse) in
                PagingInfo<Movie>(page: response.page, items: response.movies)
            }
    }
}
