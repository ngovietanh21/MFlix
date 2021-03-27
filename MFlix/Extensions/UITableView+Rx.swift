//
//  UITableView+Rx.swift
//  MFlix
//
//  Created by Viet Anh on 5/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

extension Reactive where Base: UITableView {
    func isEmpty(message: String) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setNoDataPlaceholder(message)
            } else {
                tableView.removeNoDataPlaceholder()
            }
        }
    }
}
