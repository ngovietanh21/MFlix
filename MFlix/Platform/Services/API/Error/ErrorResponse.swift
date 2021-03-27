//
//  ErrorResponse.swift
//  MFlix
//
//  Created by Viet Anh on 5/5/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse: Mappable {
    var statusMessage: String?
    var statusCode: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        statusMessage <- map["status_message"]
        statusCode <- map["status_code"]
    }
}
