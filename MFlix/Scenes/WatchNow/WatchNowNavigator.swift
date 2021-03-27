//
//  WatchNowNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowNavigatorType {
    func toMovieDetailScreen(movie: Movie)
    func toSeeAllScreen(category: CategoryType)
}

struct WatchNowNavigator: WatchNowNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let controller: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                      movie: movie)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toSeeAllScreen(category: CategoryType) {
        let controller: SeeAllViewController = assembler.resolve(navigationController: navigationController, type: category)
        navigationController.pushViewController(controller, animated: true)
    }
}
