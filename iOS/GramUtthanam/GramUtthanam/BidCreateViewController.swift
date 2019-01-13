//
//  BidCreateViewController.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import SVProgressHUD

class BidCreateViewController: UIViewController {
    
    @IBOutlet weak var cropTF: UITextField!
    @IBOutlet weak var priceRateTF: UITextField!
    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var addressFieldPlaceHolderLbl: UILabel!
    
    @IBOutlet weak var bidCreateCTABtn: UIButton!
    
    let cropsCategory: [CropCategory] = {
       return CropCategory.requestData()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cropTF.inputView = getPickerViewInput()
        cropTF.inputAccessoryView = getDoneToolbar()
        quantityTF.inputAccessoryView = getDoneToolbar()
        priceRateTF.inputAccessoryView = getDoneToolbar()
        addressTV.inputAccessoryView = getDoneToolbar()
        bidCreateCTABtn.set(enabled: isFormFilled)
    }
    
    private var isFormFilled: Bool {
        return cropTF.textCount > 0 && quantityTF.textCount > 0 && priceRateTF.textCount > 0 && addressTV.textCount > 0
    }
    
    private func getPickerViewInput() -> UIPickerView{
        let pickerView = UIPickerView()
        pickerView.dataSource = self as UIPickerViewDataSource
        pickerView.delegate = self as UIPickerViewDelegate
        return pickerView
    }
    
    private func getDoneToolbar() -> UIToolbar{
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.barStyle = .blackTranslucent
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeKeyboard))
        doneBarButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.white
            ], for: .normal)
        
        keyboardToolbar.items = [flexBarButton,doneBarButton]
        keyboardToolbar.sizeToFit()
        return keyboardToolbar
    }
    
    @IBAction func createBidAction(_ sender: UIButton) {
        view.endEditing(true)
        guard isFormFilled  else { return }
        
        let parameters: [String: Any] = [
            Constants.cropCategory: cropsCategory[cropTF.tag - 1].id,
            Constants.quantity: quantityTF.text ?? "0",
            Constants.price: priceRateTF.text ?? "0",
            Constants.pickupLocation: addressTV.text ?? ""
        ]
        SVProgressHUD.show()
        BidManager.createBid(parameters: parameters) { [weak self] (bidInfo, error) in
            SVProgressHUD.dismiss()
            guard error == nil  else { self?.showAlert(title: "Unable to Bid", message: error); return }
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func closeKeyboard() {
        if let tf = view.currentFirstResponder as? UITextField {
            if tf == cropTF {
                selectCrop(atIndex: ((cropTF.inputView as? UIPickerView)?.selectedRow(inComponent: 0) ?? 0))
                
                quantityTF.becomeFirstResponder()
                bidCreateCTABtn.set(enabled: isFormFilled)
            } else if tf == quantityTF {
                priceRateTF.becomeFirstResponder()
            } else if tf == priceRateTF {
                addressTV.becomeFirstResponder()
            }
        } else {
            view.endEditing(true)
        }
    }
    
}

extension BidCreateViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cropsCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cropsCategory[row].name
    }
    
}

extension BidCreateViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCrop(atIndex: row)
        bidCreateCTABtn.set(enabled: isFormFilled)
    }
    
    private func selectCrop(atIndex index: Int) {
        cropTF.text = cropsCategory[index].name
        cropTF.tag = index + 1
    }
    
}

extension BidCreateViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == quantityTF
        else {
            if textField == cropTF { return true }
            else if textField == priceRateTF { return string.isNumeric }
            else { return false }
        }
        
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return replacementText.isValidDouble()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        bidCreateCTABtn.set(enabled: isFormFilled)
    }
    
}

extension BidCreateViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        addressFieldPlaceHolderLbl.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        addressFieldPlaceHolderLbl.isHidden = textView.textCount != 0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        bidCreateCTABtn.set(enabled: isFormFilled)
    }
    
}


extension String {
    func isValidDouble() -> Bool {
        
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        
        if !contains(".") {
            return Double(self) != nil
        } else if formatter.number(from: self) != nil {
            let split = components(separatedBy: decimalSeparator)
            return split.last?.count ?? 1 <= 1
        }
        return false
    }
    
    var isNumeric: Bool {
        for ch in self {
            guard "0"..."9" ~= ch  else { return false }
        }
        return true
    }
    
}
