//
//  WatchNowAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol WatchNowAssembler {
    func resolve(type: WatchNowViewController.Type) -> UINavigationController
    func resolve(type: WatchNowViewController.Type) -> UITabBarItem
    func resolve() -> WatchNowViewController
    func resolve(navigationController: UINavigationController) -> WatchNowViewModel
    func resolve(navigationController: UINavigationController) -> WatchNowNavigatorType
    func resolve() -> WatchNowUseCaseType
}

extension WatchNowAssembler {
    func resolve(type: WatchNowViewController.Type) -> UINavigationController {
        let viewController: WatchNowViewController = resolve()
        let navigationController = UINavigationController(rootViewController: viewController).then {
            $0.tabBarItem = resolve(type: type)
        }
        let viewModel: WatchNowViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    func resolve(type: WatchNowViewController.Type) -> UITabBarItem {
        return UITabBarItem(title: Constants.watchNowString,
                            image: Constants.watchNowIcon,
                            selectedImage: Constants.watchNowFilled)
    }
    
    func resolve() -> WatchNowViewController {
        return WatchNowViewController.instantiate()
    }
    
    func resolve(navigationController: UINavigationController) -> WatchNowViewModel {
        return WatchNowViewModel(navigator: resolve(navigationController: navigationController),
                                 useCase: resolve())
    }
}

extension WatchNowAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> WatchNowNavigatorType {
       return WatchNowNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> WatchNowUseCaseType {
        return WatchNowUseCase(repository: resolve())
    }
}
