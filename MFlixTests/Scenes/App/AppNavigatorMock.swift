//
//  AppNavigatorMock.swift
//  MFlixTests
//
//  Created by Viet Anh on 5/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

@testable import MFlix

final class AppNavigatorMock: AppNavigatorType {
    
    var toMainTabBarCalled = false
    
    func toMainTabBar() {
        toMainTabBarCalled = true
    }
}
