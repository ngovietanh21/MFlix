//
//  SeeAllAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol SeeAllAssembler {
    func resolve(navigationController: UINavigationController, type: CategoryType) -> SeeAllViewController
    func resolve(navigationController: UINavigationController, type: CategoryType) -> SeeAllViewModel
    func resolve(navigationController: UINavigationController) -> SeeAllNavigatorType
    func resolve() -> SeeAllUseCaseType
}

extension SeeAllAssembler {
    func resolve(navigationController: UINavigationController, type: CategoryType) -> SeeAllViewController {
        let viewController =  SeeAllViewController.instantiate()
        let viewModel: SeeAllViewModel = resolve(navigationController: navigationController, type: type)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }
    
    func resolve(navigationController: UINavigationController, type: CategoryType) -> SeeAllViewModel {
        return SeeAllViewModel(navigator: resolve(navigationController: navigationController),
                               useCase: resolve(),
                               type: type)
    }
}

extension SeeAllAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SeeAllNavigatorType {
        return SeeAllNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> SeeAllUseCaseType {
        return SeeAllUseCase(seeAllRepository: resolve())
    }
}
