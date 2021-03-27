//
//  AppAssembler.swift
//  MFlix
//
//  Created by Viet Anh on 5/22/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

protocol AppAssembler {
    func resolve(window: UIWindow) -> AppNavigatorType
    func resolve(window: UIWindow) -> AppViewModel
    func resolve() -> AppUseCaseType
}

extension AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel {
        return AppViewModel(navigator: resolve(window: window),
                            useCase: resolve())
    }
}

extension AppAssembler where Self: DefaultAssembler {
    func resolve(window: UIWindow) -> AppNavigatorType {
        return AppNavigator(assembler: self, window: window)
    }
    
    func resolve() -> AppUseCaseType {
        return AppUseCase()
    }
}
