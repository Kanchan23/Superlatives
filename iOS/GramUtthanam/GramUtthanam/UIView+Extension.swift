//
//  UIView+Extension.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func add(dict: [Key: Value]) -> [Key: Value] {
        var resultingDict = self
        
        for (key, value) in dict {
            resultingDict[key] = value
        }
        
        return resultingDict
    }
    
}

extension Decodable {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
}


extension UITextField {
    
    var textCount: Int {
        return text?.trimmingCharacters(in: .whitespaces).count ?? 0
    }
    
}

extension UITextView {
    
    var textCount: Int {
        return text?.trimmingCharacters(in: .whitespaces).count ?? 0
    }
    
}


extension UIView {

    func set(enabled isEnabled: Bool) {
        isUserInteractionEnabled = isEnabled
        alpha = isEnabled ? 1 : 0.4
    }
    
    @IBInspectable private var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor  else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set(newBorderColor) { layer.borderColor = newBorderColor?.cgColor }
    }

    func createNAddTapGesture(action: Selector, target: Any) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
        return tap
    }
    
}

extension UIView {
    
    var currentFirstResponder: UIView? {
        guard !self.isFirstResponder  else { return self }
        for view in self.subviews {
            guard let view = view.currentFirstResponder  else { continue }
            return view
        }
        return nil
    }
    
}
