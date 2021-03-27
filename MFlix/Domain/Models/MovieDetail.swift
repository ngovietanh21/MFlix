//
//  MovieDetail.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

struct MovieDetail {
    var genres: [Genre] = []
    var id = 0
    var originalTitle = ""
    var overview = ""
    var tagline = ""
    var title = ""
    var hasVideo = false
    private var backdropPath = ""
    private var posterPath = ""
    
    var hasBackDropImage: Bool {
        return !backdropPath.isEmpty
    }
    
    var posterImageOriginalUrl: String {
        return URLs.Image.original + posterPath
    }
    
    var posterImageW500Url: String {
        return URLs.Image.w500 + posterPath
    }
    
    var backdropImageOPriginalUrl: String {
        return URLs.Image.original + backdropPath
    }
    
    var backdropImageW500Url: String {
        return URLs.Image.w500 + backdropPath
    }
    
}

extension MovieDetail: BaseModel {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        backdropPath <- map["backdrop_path"]
        genres <- map["genres"]
        id <- map["id"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        tagline <- map["tagline"]
        title <- map["title"]
        hasVideo <- map["video"]
    }
}
