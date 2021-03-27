//
//  Video.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

struct Video {
    var id = ""
    var key = ""
    var name = ""
    var site = ""
    var type = ""
    var size = 0
}

extension Video: BaseModel {
    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        type <- map["type"]
        size <- map["size"]
    }
}
