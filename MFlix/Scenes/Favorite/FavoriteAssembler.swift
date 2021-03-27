//
//  FavoriteAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol FavoriteAssembler {
    func resolve(type: FavoriteViewController.Type) -> UINavigationController
    func resolve(type: FavoriteViewController.Type) -> UITabBarItem
    func resolve() -> FavoriteViewController
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType
    func resolve() -> FavoriteUseCaseType
}

extension FavoriteAssembler {
    func resolve(type: FavoriteViewController.Type) -> UINavigationController {
        let viewController: FavoriteViewController = resolve()
        let navigationController = UINavigationController(rootViewController: viewController).then {
            $0.tabBarItem = resolve(type: FavoriteViewController.self)
        }
        let viewModel: FavoriteViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func resolve(type: FavoriteViewController.Type) -> UITabBarItem {
       return UITabBarItem(title: Constants.favoriteString,
                           image: Constants.favoriteIcon,
                           selectedImage: Constants.favoriteFilled)
    }
    
    func resolve() -> FavoriteViewController {
        return FavoriteViewController.instantiate()
    }
    
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel {
        return FavoriteViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve())
    }
}

extension FavoriteAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType {
       return FavoriteNavigator(assembler: self,
                                navigationController: navigationController)
    }
    
    func resolve() -> FavoriteUseCaseType {
        return FavoriteUseCase(repository: resolve())
    }
}
