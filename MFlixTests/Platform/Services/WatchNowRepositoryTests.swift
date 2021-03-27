//
//  WatchNowRepositoryTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
import Mockingjay
@testable import MFlix

final class WatchNowRepositoryTests: XCTestCase {
    
    let url = URLs.API.upcoming
    var repository: WatchNowRepositoryType!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = WatchNowRepository()
    }

    func test_Repo_Success() {
        // arrange
        var output: [Movie]?
        let data = loadStub(name: "WatchNow", extension: "json")
        let stubURL = url

        // act
        self.stub(uri(stubURL), jsonData(data as Data))
        let input = CategoryRequest(category: .upcoming, page: 1)
        output = try? repository.getMovieList(input: input).toBlocking().first()

        // assert
        XCTAssertNotNil(output)
        XCTAssert(output?.count == 20)
        XCTAssert(output?.first?.id == 508439)
        XCTAssert(output?.first?.title == "Onward")
    }
}
