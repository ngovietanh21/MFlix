//
//  SeeAllViewModel.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

struct SeeAllViewModel {
    let navigator: SeeAllNavigatorType
    let useCase: SeeAllUseCaseType
    let type: CategoryType
}

extension SeeAllViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let title: Driver<String>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let movieSelected: Driver<Movie>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadItems = getPage(loadTrigger: input.loadTrigger,
                                reloadTrigger: input.reloadTrigger,
                                loadMoreTrigger: input.loadMoreTrigger) { page in
                                    self.useCase.loadMoreMovie(category: self.type, page: page)
                                }
        
        let (page, error, isLoading, isReloading, isLoadingMore) = loadItems.destructured
        
        let movies = page
            .map { $0.items }
        
        let title = input.loadTrigger
            .map { self.type.title }
        
        let movieSelected = input.selectMovieTrigger
            .withLatestFrom(movies) { $1[$0.row] }
            .do(onNext: {
                self.navigator.toMovieDetailScreen(movie: $0)
            })
        
        return Output(movies: movies,
                      title: title,
                      error: error,
                      isLoading: isLoading,
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      movieSelected: movieSelected)
    }
}
