//
//  PersonTests.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import XCTest
@testable import MFlix

final class PersonTests: XCTestCase {
    
    func testMappingPerson() {
        let json: [String: Any] = [
            "id": 1,
            "character": "FooooBarrr",
            "profile_path": "foo",
            "name": "bar"
        ]
        let actor = Person(JSON: json)
        XCTAssertNotNil(actor)
        XCTAssertEqual(actor?.id, json["id"] as? Int)
        XCTAssertEqual(actor?.character, json["character"] as? String)
        XCTAssertEqual(actor?.name, json["name"] as? String)
        guard let path = json["profile_path"] as? String else { return XCTFail() }
        XCTAssertEqual(actor?.imageOriginalUrl, URLs.Image.original + path)
    }
}
