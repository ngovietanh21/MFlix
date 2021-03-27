//
//  SearchNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchNavigatorType {
    func toMovieDetailScreen(movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let controller: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                      movie: movie)
        navigationController.pushViewController(controller, animated: true)
    }
}
