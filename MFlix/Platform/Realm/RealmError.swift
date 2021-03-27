//
//  RealmError.swift
//  MFlix
//
//  Created by Viet Anh on 5/20/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

enum RealmError: Error {
    case addFail
    case deleteFail
    case itemExist
    case cannotInitObject
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .addFail:
            return "Cant add this item. Try again later"
        case .deleteFail:
            return "Cant delete this item. Try again later"
        case .itemExist:
            return "This item exists in favorite list."
        case .cannotInitObject:
            return "Cannot find default.realm in your device"
        }
    }
}
