//
//  SeeAllNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SeeAllNavigatorType {
   func toMovieDetailScreen(movie: Movie)
}

struct SeeAllNavigator: SeeAllNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let controller: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                      movie: movie)
        navigationController.pushViewController(controller, animated: true)
    }
}
