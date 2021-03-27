//
//  MovieDetailRepository.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol MovieDetailRepositoryType {
    func getMovieDetail(input: MovieDetailRequest) -> Observable<MovieDetail>
    func getCastForMovie(input: MovieActorsRequest) -> Observable<[Person]>
    func getSimilarMovies(input: SimilarMoviesRequest) -> Observable<[Movie]>
    func getTrailersMovie(input: TrailersMovieRequest) -> Observable<[Video]>
}

final class MovieDetailRepository: MovieDetailRepositoryType {
    
    private let api: APIService = APIService.share
    
    func getMovieDetail(input: MovieDetailRequest) -> Observable<MovieDetail> {
        return api.request(input: input)
    }
    
    func getCastForMovie(input: MovieActorsRequest) -> Observable<[Person]> {
        return api.request(input: input)
            .map { (response: MovieActorsResponse) in
                return response.actors
            }
    }
    
    func getSimilarMovies(input: SimilarMoviesRequest) -> Observable<[Movie]> {
        return api.request(input: input)
            .map { (response: CategoryResponse) in
                return response.movies
            }
    }
    
    func getTrailersMovie(input: TrailersMovieRequest) -> Observable<[Video]> {
        return api.request(input: input)
            .map { (response: TrailersMovieResponse) in
                return response.videos
            }
    }
}
