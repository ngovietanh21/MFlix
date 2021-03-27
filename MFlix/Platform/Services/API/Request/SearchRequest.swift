//
//  SearchRequest.swift
//  MFlix
//
//  Created by Viet Anh on 5/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class SearchRequest: BaseRequest {
    
    required init(query: String, page: Int = 1) {
        let body: [String: Any] = [
            "api_key": APIKey.apiKey,
            "query": query,
            "page": page
        ]
        super.init(url: URLs.API.searchMovie, requestType: .get, body: body)
    }
}
