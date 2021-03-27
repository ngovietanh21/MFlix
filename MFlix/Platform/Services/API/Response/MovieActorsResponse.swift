//
//  MovieActorsResponse.swift
//  MFlix
//
//  Created by Viet Anh on 5/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

final class MovieActorsResponse: BaseModel {
    var actors = [Person]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        actors <- map["cast"]
    }
}
