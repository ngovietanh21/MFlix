//
//  TrailersMovieResponse.swift
//  MFlix
//
//  Created by Viet Anh on 5/19/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

final class TrailersMovieResponse: BaseModel {
    var videos = [Video]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        videos <- map["results"]
    }
}
