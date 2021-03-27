//
//  MovieDetailAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol MovieDetailAssembler {
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewModel
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType
    func resolve() -> MovieDetailUseCaseType
}

extension MovieDetailAssembler {
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()
        let viewModel: MovieDetailViewModel = resolve(navigationController: navigationController, movie: movie)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewModel {
        return MovieDetailViewModel(navigator: resolve(navigationController: navigationController),
                                    useCase: resolve(),
                                    movie: movie)
    }
}

extension MovieDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MovieDetailNavigatorType {
        return MovieDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MovieDetailUseCaseType {
        return MovieDetailUseCase(repository: resolve(),
                                  favoriteRepository: resolve())
    }
}
