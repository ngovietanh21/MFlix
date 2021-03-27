//
//  WatchNowRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowRepositoryType {
    func getMovieList(input: CategoryRequest) -> Observable<[Movie]>
}

final class WatchNowRepository: WatchNowRepositoryType {
    
    private let api: APIService = APIService.share
    
    func getMovieList(input: CategoryRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: CategoryResponse) in
                return response.movies
            }
    }
}
