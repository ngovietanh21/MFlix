//
//  WatchNowResponse.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

final class CategoryResponse: BaseModel {
    var movies = [Movie]()
    var page = 0
    var totalPage = 0
    var totalResult = 0
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
        totalResult <- map["total_results"]
        page <- map["page"]
        totalPage <- map["total_pages"]
    }
}
