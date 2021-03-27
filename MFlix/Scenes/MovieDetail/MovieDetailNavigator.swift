//
//  MovieDetailNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/12/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func toMovieDetailScreen(movie: Movie)
    func toTrailerVideoScreen(video: Video)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let controller: MovieDetailViewController = assembler.resolve(navigationController: navigationController,
                                                                      movie: movie)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toTrailerVideoScreen(video: Video) {
        let player = YTSwiftyPlayer(frame: .zero, playerVars: [.videoID(video.key)])
        let _ = UIViewController().then {
            $0.view = player
            player.autoplay = true
            navigationController.present($0, animated: true) {
                player.loadPlayer()
            }
        }
    }
}
