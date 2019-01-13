//
//  UIViewController+Extension.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func perform(segue: Segue, userInfo: Any? = nil) {
        if shouldPerformSegue(withIdentifier: segue.rawValue, sender: userInfo) {
            performSegue(withIdentifier: segue.rawValue, sender: userInfo)
        }
    }
    
    func showAlert(title: String?, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message ?? RequestError.commonErrorMsg)
        present(alertController, animated: true, completion: nil)
    }
    
    func remove(childViewController viewController: UIViewController?) -> Bool {
        guard let controller = viewController else { return false }
        
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        return true
    }
    
}

