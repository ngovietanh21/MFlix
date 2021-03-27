//
//  SearchViewModelTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix
import XCTest
import RxBlocking

final class SearchViewModelTests: XCTestCase {
    
    private var navigator: SearchNavigatorMock!
    private var useCase: SearchUseCaseMock!
    private var viewModel: SearchViewModel!
    
    private var input: SearchViewModel.Input!
    private var output: SearchViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let textSearch = PublishSubject<String>()
    private let reloadTrigger = PublishSubject<Void>()
    private let loadMoreTrigger =  PublishSubject<Void>()
    private let selectMovieTrigger = PublishSubject<IndexPath>()

    override func setUpWithError() throws {
        navigator = SearchNavigatorMock()
        useCase = SearchUseCaseMock()
        viewModel = SearchViewModel(navigator: navigator, useCase: useCase)
        
        input = SearchViewModel.Input(textSearch: textSearch.asDriverOnErrorJustComplete(),
                                      reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
                                      loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
                                      selectMovieTrigger: selectMovieTrigger.asDriverOnErrorJustComplete())
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.movies.debug().drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
        output.isLoading.drive().disposed(by: disposeBag)
        output.isReloading.drive().disposed(by: disposeBag)
        output.isLoadingMore.drive().disposed(by: disposeBag)
        output.isEmptyMovie.drive().disposed(by: disposeBag)
        output.isEmptyString.drive().disposed(by: disposeBag)
        output.movieSelected.drive().disposed(by: disposeBag)
    }
    
    func test_textSearchInvoked_getListMovies() {
        textSearch.onNext("VietAnh")
        
        let movieList = try? output.movies.toBlocking(timeout: 1).first()
        // assert
        XCTAssertEqual(movieList?.count, 1)
        XCTAssert(useCase.loadMoreMovieCalled)
    }
    
    func test_textSearchInvoked_getMovieList_failedShowError() {
        // arrange
        useCase.getListMovieReturnValue = Observable.error(TestError())

        // act
        textSearch.onNext("sadfsadkjfahsdlfkjhasdf")
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.loadMoreMovieCalled)
        XCTAssert(error is TestError)
    }
    
    func test_reloadTriggerInvoked_getMovieList() {
        // act
        textSearch.onNext("")
        reloadTrigger.onNext(())
        let movieList = try? output.movies.toBlocking(timeout: 1).first()

        // assert
        XCTAssertEqual(movieList?.count, 1)
        XCTAssert(useCase.loadMoreMovieCalled)
    }
    
    func test_reloadTriggedInvoked_getMovieList_failedShowError() {
        // arrange
        useCase.getListMovieReturnValue = Observable.error(TestError())
        reloadTrigger.onNext(())
        
        // act
        textSearch.onNext("sadfsadkjfahsdlfkjhasdf")
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.loadMoreMovieCalled)
        XCTAssert(error is TestError)
    }
    
    func test_selectMovieTriggedInvoked_toMovieDetail() {
        textSearch.onNext("")
        selectMovieTrigger.onNext(IndexPath(item: 0, section: 0))
        
        XCTAssert(navigator.toMovieDetailCalled)
    }
    
    func test_textSearchTriggedInvoked_isEmptyString() {
        textSearch.onNext("")
        
        let isEmptyString = try? output.isEmptyString.toBlocking().first()
        
        XCTAssert(isEmptyString == true)
    }
    
    func test_textSearchTriggedInvoked_isEmptyMovie() {
        useCase.getListMovieReturnValue = .just(PagingInfo<Movie>(page: 1, items: []))
        textSearch.onNext("")
        
        let isEmptyMovie = try? output.isEmptyMovie.toBlocking().first()
        XCTAssert(useCase.loadMoreMovieCalled)
        XCTAssert(isEmptyMovie == true)
    }
}
