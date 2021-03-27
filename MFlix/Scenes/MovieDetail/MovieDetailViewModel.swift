//
//  MovieDetailViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

// MARK: - DataSource
enum MovieDetailTableViewCellType {
    case trailer(videos: [Video])
    case related(movies: [Movie])
    case cast(cast: [Person])
    
    var section: String {
        switch self {
        case .trailer:
            return "Trailer"
        case .cast:
            return "Cast & Crew"
        case .related:
            return "Related"
        }
    }
    
    var numberOfItems: Int {
        switch self {
        case .cast(let cast):
            return cast.count
        case .related(let movies):
            return movies.count
        case .trailer(let videos):
            return videos.count
        }
    }
}

//MARK: - View Model
struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let useCase: MovieDetailUseCaseType
    let movie: Movie
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let buttonFavoriteTrigger: Driver<Void>
        let movieDetailTrigger: Driver<Movie>
        let trailerVideoTrigger: Driver<Video>
    }
    
    struct Output {
        let movieDetail: Driver<MovieDetail>
        let movieDetailSection: Driver<[MovieDetailTableViewCellType]>
        let movieDetailSelected: Driver<Void>
        let trailerVideoSelected: Driver<Void>
        let buttonFavoriteSelected: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movieDetail = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getMovieDetail(movie: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        let cast = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getCastForMovie(movie: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        let similarMovies = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getSimilarMovies(movie: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        let trailersVideo = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getTrailersMovie(movie: self.movie)
                .asDriverOnErrorJustComplete()
            }
        
        let trailerVideoSelected = input.trailerVideoTrigger
            .do(onNext: {
                self.navigator.toTrailerVideoScreen(video: $0)
            })
            .mapToVoid()
        
        let movieDetailSelected = input.movieDetailTrigger
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movie: $0)
            })
            .mapToVoid()
        
        let movieDetailSection = Driver.combineLatest(cast, similarMovies, trailersVideo)
            .map { self.combineLastest(from: $0, $1, $2) }
        
        let buttonFavoriteSelected = input.buttonFavoriteTrigger
            .flatMapLatest { _ in
                self.useCase.toggleFavoriteButton(movie: self.movie)
                    .asDriverOnErrorJustComplete()
            }
            .startWith(useCase.getStatusMovie(movie: self.movie))
        
        return Output(movieDetail: movieDetail,
                      movieDetailSection: movieDetailSection,
                      movieDetailSelected: movieDetailSelected,
                      trailerVideoSelected: trailerVideoSelected,
                      buttonFavoriteSelected: buttonFavoriteSelected)
    }
    
    private func combineLastest(from cast: [Person],
                                _ similarMovies: [Movie],
                                _ trailersVideo: [Video]) -> [MovieDetailTableViewCellType] {
        var array: [MovieDetailTableViewCellType] = []
        
        if !trailersVideo.isEmpty {
            array.append(.trailer(videos: trailersVideo))
        }
        
        if !similarMovies.isEmpty {
            array.append(.related(movies: similarMovies))
        }
        
        if !cast.isEmpty {
            array.append(.cast(cast: cast))
        }
        
        return array
    }
}
