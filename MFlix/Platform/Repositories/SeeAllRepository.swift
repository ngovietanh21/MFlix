//
//  SeeAllRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SeeAllRepositoryType {
    func getMovieList(input: CategoryRequest) -> Observable<PagingInfo<Movie>>
}

final class SeeAllRepository: SeeAllRepositoryType {

    private let api: APIService = APIService.share
    
    func getMovieList(input: CategoryRequest) -> Observable<PagingInfo<Movie>> {
        return api.request(input: input)
            .map { (response: CategoryResponse) in
                PagingInfo<Movie>(page: response.page, items: response.movies)
            }
    }
}
