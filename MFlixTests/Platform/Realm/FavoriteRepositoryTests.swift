//
//  FavoriteRepositoryTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class FavoriteRepositoryTests: XCTestCase {
    
    var repository: FavoriteRepositoryType!
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        repository = FavoriteRepository()
    }
    
    func test_add_movieToFavorite() {
        
        _ = repository.add(Movie().with { $0.id = 1 })

        let movies = try! repository.getAllMovies().toBlocking().first()
        
        XCTAssert(movies?.count == 1)
        XCTAssert(repository.checkExist(Movie().with { $0.id = 1 }))
    }
    
    func test_deleted_movieFromFavorite() {
        _ = repository.add(Movie().with { $0.id = 1 })
        var movies = try! repository.getAllMovies().toBlocking().first()
        
        XCTAssert(movies?.count == 1)
        
        _ = repository.delete(Movie().with { $0.id = 1 })
        movies = try! repository.getAllMovies().toBlocking().first()
    
        XCTAssertEqual(movies?.count, 0)
    }
}
