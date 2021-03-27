//
//  SearchAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SearchAssembler {
    func resolve(type: SearchViewController.Type) -> UINavigationController
    func resolve(type: SearchViewController.Type) -> UITabBarItem
    func resolve() -> SearchViewController
    func resolve(navigationController: UINavigationController) -> SearchViewModel
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType
    func resolve() -> SearchUseCaseType
}

extension SearchAssembler {
    func resolve(type: SearchViewController.Type) -> UINavigationController {
        let viewController: SearchViewController = resolve()
        let navigationController = UINavigationController(rootViewController: viewController).then {
            $0.tabBarItem = resolve(type: SearchViewController.self)
        }
        let viewModel: SearchViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func resolve(type: SearchViewController.Type) -> UITabBarItem {
       return UITabBarItem(title: Constants.searchString,
                           image: Constants.searchIcon,
                           selectedImage: Constants.searchFilled)
    }
    
    func resolve() -> SearchViewController {
        return SearchViewController.instantiate()
    }
    
    func resolve(navigationController: UINavigationController) -> SearchViewModel {
        return SearchViewModel(navigator: resolve(navigationController: navigationController),
                               useCase: resolve())
    }
}

extension SearchAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType {
       return SearchNavigator(assembler: self,
                              navigationController: navigationController)
    }
    
    func resolve() -> SearchUseCaseType {
        return SearchUseCase(repository: resolve())
    }
}
