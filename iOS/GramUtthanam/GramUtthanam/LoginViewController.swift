//
//  LoginViewController.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginCTABtn: UIButton!
    
    
    private var isFormFilled: Bool {
        return (phoneNumberTF.textCount > 0) && (passwordTF.textCount > 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginCTABtn.set(enabled: isFormFilled)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard isFormFilled  else { return }
        let parameters = [
            Constants.phoneNumKey: phoneNumberTF.text ?? "",
            Constants.passwordKey: passwordTF.text ?? ""
        ]
        SVProgressHUD.show()
        Authenticator.login(parameters: parameters) { [weak self] (user: User?, errorMessage) in
            SVProgressHUD.dismiss()
            if let user = user {
                UserCache.userToken.value = user.token
                self?.perform(segue: .mainApp)
            } else {
                self?.showAlert(title: "Login Error", message: errorMessage)
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    @IBAction func textChanged(_ sender: UITextField) {
        loginCTABtn.set(enabled: isFormFilled)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty, textField == phoneNumberTF  else { return true }
        return string.isNumeric && ((textField.textCount + string.count - range.length) <= 10)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == phoneNumberTF {
            passwordTF.becomeFirstResponder()
        }
        return true
    }
    
}
