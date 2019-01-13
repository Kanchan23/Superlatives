//
//  UIAlertViewController+Extension.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    private static var okayButton: UIAlertAction { return UIAlertAction(title: "Okay", style: .default, handler: nil) }
    
    convenience init(title: String? = nil, message: String? = nil, style: Style = .alert, actions: [UIAlertAction] = [okayButton]) {
        self.init(title: title, message: message, preferredStyle: style)
        actions.forEach { addAction($0) }
    }

}
