//
//  MovieTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class MovieTests: XCTestCase {
    
    func test_mapping_movie() {
        let json: [String: Any] = [
            "popularity": 188.004,
            "vote_count": 2408,
            "video": false,
            "poster_path": "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
            "id": 338762,
            "adult": false,
            "backdrop_path": "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg",
            "original_language": "en",
            "original_title": "Bloodshot",
            "genre_ids": [
              28,
              878
            ],
            "title": "Bloodshot",
            "vote_average": 7.1,
            "overview": "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.",
            "release_date": "2020-03-05"
        ]
        
        let movieMapping = Movie(JSON: json)
        guard let movie = movieMapping else { return XCTFail() }
        XCTAssertEqual(movie.id, json["id"] as? Int)
        XCTAssertEqual(movie.originalTitle, json["original_title"] as? String)
        XCTAssertEqual(movie.title, json["title"] as? String)
        XCTAssert(movie.hasBackDropImage)
    }
}
