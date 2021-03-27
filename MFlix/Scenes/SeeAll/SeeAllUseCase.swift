//
//  SeeAllUseCase.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SeeAllUseCaseType {
    func getListMovie(category: CategoryType) -> Observable<PagingInfo<Movie>>
    func loadMoreMovie(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>>
}

struct SeeAllUseCase: SeeAllUseCaseType {
    
    let seeAllRepository: SeeAllRepositoryType
    
    func getListMovie(category: CategoryType) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovie(category: category, page: 1)
    }
    
    func loadMoreMovie(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        let request = CategoryRequest(category: category, page: page)
        return seeAllRepository.getMovieList(input: request)
    }
}
