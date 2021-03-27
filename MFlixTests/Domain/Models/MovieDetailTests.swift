//
//  MovieDetailTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class MovieDetailTests: XCTestCase {
    func test_mapping_movieDetail() {
        let json: [String: Any] = [
              "adult": false,
              "backdrop_path": "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg",
              "budget": 42000000,
              "genres": [
                  ["id": 28,
                  "name": "Action"
                ],
                  ["id": 878,
                  "name": "Science Fiction"]
              ],
              "homepage": "https://www.bloodshot.movie/",
              "id": 338762,
              "imdb_id": "tt1634106",
              "original_language": "en",
              "original_title": "Bloodshot",
              "overview": "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.",
              "popularity": 188.004,
              "poster_path": "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
              "production_companies": [
                [
                  "id": 34,
                  "logo_path": "/GagSvqWlyPdkFHMfQ3pNq6ix9P.png",
                  "name": "Sony Pictures",
                  "origin_country": "US"]
                ,
                
                 [ "id": 10246,
                  "logo_path": "/rREvQNWAxkDfY9CDn2c5YxEMPdP.png",
                  "name": "Cross Creek Pictures",
                  "origin_country": "US"]
                ,
                
                 [ "id": 6573,
                  "name": "Mimran Schur Pictures",
                  "origin_country": "US"]
                ,
                
                 [ "id": 333,
                  "logo_path": "/5xUJfzPZ8jWJUDzYtIeuPO4qPIa.png",
                  "name": "Original Film",
                  "origin_country": "US"]
                ,
                
                 [ "id": 103673,
                  "name": "The Hideaway Entertainment",
                  "origin_country": "US"]
                ,
                
                [  "id": 124335,
                  "logo_path": "/tnygXlYGY04uGaMoXqbS34FBsTJ.png",
                  "name": "Valiant Entertainment",
                  "origin_country": "US"]
                ,
                
                 [ "id": 5,
                  "logo_path": "/71BqEFAF4V3qjjMPCpLuyJFB9A.png",
                  "name": "Columbia Pictures",
                  "origin_country": "US"]
                ,
                
                 [ "id": 1225,
                  "name": "One Race",
                  "origin_country": "US"]
                ,
                 [ "id": 30148,
                  "logo_path": "/zerhOenUD6CkH8SMgZUhrDkOs4w.png",
                  "name": "Bona Film Group",
                  "origin_country": "CN"]
                
              ],
              "production_countries": [
                 [ "iso_3166_1": "CN",
                  "name": "China"]
                ,
                 [ "iso_3166_1": "US",
                  "name": "United States of America"]
              ],
              "release_date": "2020-03-05",
              "revenue": 24573617,
              "runtime": 110,
              "spoken_languages": [
                  "iso_639_1": "en",
                  "name": "English"
              ],
              "status": "Released",
              "tagline": "Being a superhero is in his blood",
              "title": "Bloodshot",
              "video": false,
              "vote_average": 7.1,
              "vote_count": 2408
        ]
        let movieMapping = MovieDetail(JSON: json)
        guard let movie = movieMapping else { return  XCTFail() }
        XCTAssert(type(of: movie.genres) == [Genre].self )
    }
}
