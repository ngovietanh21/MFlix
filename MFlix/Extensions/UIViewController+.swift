//
//  UIViewController+.swift
//  MFlix
//
//  Created by Viet Anh on 5/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

extension UIViewController {
    func showError(message: String, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showAlertView(title: String?,
                       message: String?,
                       style: UIAlertController.Style,
                       actions: [(String, UIAlertAction.Style)]) -> Observable<Int> {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.0,
                                           style: action.1) { _ in
                                            observer.onNext(index)
                                            observer.onCompleted()
                }
                alertController.addAction(action)
            }
            self.present(alertController,
                         animated: true,
                         completion: nil)
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
