//
//  AppNavigator.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol AppNavigatorType {
    func toMainTabBar()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMainTabBar() {
        let watchNowNavigationController: UINavigationController = assembler.resolve(type: WatchNowViewController.self)
        let favoriteNavigationController: UINavigationController = assembler.resolve(type: FavoriteViewController.self)
        let searchNavigationController: UINavigationController = assembler.resolve(type: SearchViewController.self)

        //MARK: - TabBar
        let mainTabBarController = UITabBarController().then {
            $0.viewControllers = [watchNowNavigationController,
                                  favoriteNavigationController,
                                  searchNavigationController]
        }
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }
}
