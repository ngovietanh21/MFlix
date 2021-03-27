//
//  CategoryType.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

enum CategoryType {
    case popular
    case upcoming
    case topRated
    case nowPlaying
    
    var url: String {
        switch self {
        case .popular:
            return URLs.API.popular
        case .upcoming:
            return URLs.API.upcoming
        case .topRated:
            return URLs.API.topRated
        case .nowPlaying:
            return URLs.API.nowPlaying
        }
    }
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .nowPlaying:
            return "Now Playing"
        }
    }
}
