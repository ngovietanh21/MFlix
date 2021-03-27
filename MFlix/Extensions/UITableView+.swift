//
//  UITableView+.swift
//  MFlix
//
//  Created by Viet Anh on 5/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(
                        frame: CGRect(x: 0, y: 0,
                                      width: bounds.size.width,
                                      height: bounds.size.height)).then {
            $0.text = message
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.sizeToFit()
        }
        
        self.do {
            $0.isScrollEnabled = false
            $0.backgroundView = label
            $0.separatorStyle = .none
        }
    }
    
    func removeNoDataPlaceholder() {
        self.do {
            $0.isScrollEnabled = true
            $0.backgroundView = nil
            $0.separatorStyle = .singleLine
        }
    }
}
