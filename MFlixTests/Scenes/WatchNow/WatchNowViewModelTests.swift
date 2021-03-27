//
//  WatchNowViewModelTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

class WatchNowViewModelTests: XCTestCase {
    
    private var viewModel: WatchNowViewModel!
    private var navigator: WatchNowNavigatorMock!
    private var useCase: WatchNowUseCaseMock!
    
    private var input: WatchNowViewModel.Input!
    private var output: WatchNowViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let seeAllTrigger = PublishSubject<CategoryType>()
    private let movieDetailTrigger = PublishSubject<Movie>()

    override func setUpWithError() throws {
        navigator = WatchNowNavigatorMock()
        useCase = WatchNowUseCaseMock()
        viewModel = WatchNowViewModel(navigator: navigator, useCase: useCase)
        
        input = WatchNowViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                        seeAllTrigger: seeAllTrigger.asDriverOnErrorJustComplete(),
                                        movieDetailTrigger: movieDetailTrigger.asDriverOnErrorJustComplete())
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.items.drive().disposed(by: disposeBag)
        output.movieDetailSelected.drive().disposed(by: disposeBag)
        output.seeAllSelected.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getAllMovieList() {
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(useCase.getNowPlayingCalled)
        XCTAssert(useCase.getPopularCalled)
        XCTAssert(useCase.getTopRatedCalled)
        XCTAssert(useCase.getUpcomingCalled)
        XCTAssert(useCase.mergeItemsCalled)
    }
    
    func test_seeAllTriggerInvoked_toSeeAllScreen() {
        seeAllTrigger.onNext(.nowPlaying)
        
        XCTAssert(navigator.toSeeAllScreenCalled)
    }
    
    func test_movieDetailTrigeedInvoked_toMovieDetaillScreen() {
        movieDetailTrigger.onNext(Movie())
        
        XCTAssert(navigator.toMovieDetailCalled)
    }
}
