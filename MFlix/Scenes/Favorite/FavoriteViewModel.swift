//
//  FavoriteViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

extension FavoriteViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let deletedMovieTrigger: Driver<IndexPath>
        let selectedMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let selectedMovie: Driver<Movie>
        let isEmptyMovie: Driver<Bool>
        var deletedMovie: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movies = input.loadTrigger
            .flatMapLatest { _ in
                self.useCase.getAllMovies()
                    .asDriverOnErrorJustComplete()
            }
        
        let selectedMovie = input.selectedMovieTrigger
            .withLatestFrom(movies) { $1[$0.row] }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movie: $0)
            })
        
        let isEmptyMovie = movies
            .map { $0.isEmpty }
            .distinctUntilChanged()
        
        let deletedMovie = input.deletedMovieTrigger
            .withLatestFrom(movies) { $1[$0.row] }
            .flatMapLatest {
                self.navigator.showAlertDelete(movie: $0)
                    .asDriverOnErrorJustComplete()
            }
            .flatMapLatest {
                self.useCase.delete($0)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(movies: movies,
                      selectedMovie: selectedMovie,
                      isEmptyMovie: isEmptyMovie,
                      deletedMovie: deletedMovie)
    }
}
