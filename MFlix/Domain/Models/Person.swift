//
//  Person.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

struct Person {
    var character = ""
    var id = 0
    var name = ""
    private var profilePath = ""
    
    var imageOriginalUrl: String {
        return URLs.Image.original + profilePath
    }
}

extension Person: BaseModel {
    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        character <- map["character"]
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
