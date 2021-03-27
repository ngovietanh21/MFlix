//
//  VideoTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class VideoTests: XCTestCase {
    
    func test_mapping_video() {
        let json: [String: Any] = [
            "id": "5dad5e3afea6e30011ada0ab",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "F95Fk255I4M",
            "name": "BLOODSHOT – International Trailer",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
        ]
        let videoMapping = Video(JSON: json)
        guard let video = videoMapping else { return XCTFail() }
        XCTAssertEqual(video.id, json["id"] as? String)
        XCTAssertEqual(video.key, json["key"] as? String)
        XCTAssertEqual(video.name, json["name"] as? String)
        XCTAssertEqual(video.site, json["site"] as? String)
        XCTAssertEqual(video.type, json["type"] as? String)
        XCTAssertEqual(video.size, json["size"] as? Int)
    }
}
