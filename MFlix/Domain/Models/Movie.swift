//
//  Movie.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import ObjectMapper

final class Movie: Object {
    @objc dynamic var id = 0
    @objc dynamic var originalTitle = ""
    @objc dynamic var title = ""
    @objc dynamic private var posterPath = ""
    @objc dynamic private var backdropPath = ""
    @objc dynamic var addRealmDate = Date()
    
    var hasBackDropImage: Bool {
        return !backdropPath.isEmpty
    }
    
    var posterImageOriginalUrl: String {
        return URLs.Image.original + posterPath
    }
    
    var posterImageW500Url: String {
        return URLs.Image.w500 + posterPath
    }
    
    var backdropImageOriginalUrl: String {
        return URLs.Image.original + backdropPath
    }
    
    var backdropImageW500Url: String {
        return URLs.Image.w500 + backdropPath
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Movie: BaseModel {
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        posterPath <- map["poster_path"]
        id <- map["id"]
        backdropPath <- map["backdrop_path"]
        originalTitle <- map["original_title"]
        title <- map["title"]
    }
}
