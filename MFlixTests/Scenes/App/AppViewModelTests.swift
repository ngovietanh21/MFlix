//
//  AppViewModelTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class AppViewModelTests: XCTestCase {
    
    private var viewModel: AppViewModel!
    private var navigator: AppNavigatorMock!
    private var useCase: AppUseCaseMock!
    
    private var input: AppViewModel.Input!
    private var output: AppViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        navigator = AppNavigatorMock()
        useCase = AppUseCaseMock()
        viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        
        input = AppViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.toMainTabBar.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_toMainTabBar() {
        // act
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(navigator.toMainTabBarCalled)
    }
}
