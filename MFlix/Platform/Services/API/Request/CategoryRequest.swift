//
//  CategoryRequest.swift
//  MFlix
//
//  Created by Viet Anh on 5/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

final class CategoryRequest: BaseRequest {
    
    required init(category: CategoryType , page: Int = 1) {
        let body: [String: Any] = [
            "api_key": APIKey.apiKey,
            "page": page
        ]
        super.init(url: category.url, requestType: .get, body: body)
    }
}
