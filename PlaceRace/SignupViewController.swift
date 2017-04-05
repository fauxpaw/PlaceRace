//
//  SignupViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/4/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import ParseUI

class SignupViewController: PFSignUpViewController, UITextViewDelegate {
    
    var errorsList = TextViewManager()
    var passwordField: PFTextField { return (self.signUpView?.passwordField)! }
    var userNameField: PFTextField {return (self.signUpView?.usernameField)! }
    var emailField: PFTextField {return (self.signUpView?.emailField)!}
    var additionalField: PFTextField {return (self.signUpView?.additionalField)!}
    var textFields = [PFTextField]()
    let minimumPasswordLength = 7
    let minimumUsernameLength = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFieldValidation()
    }
    
    fileprivate func setupTextFieldValidation() {
        
        self.textFields = [self.userNameField, self.passwordField, self.emailField, self.additionalField]
        for field in self.textFields {
            field.delegate = self
            field.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
            field.clearButtonMode = .unlessEditing
        }
    
        let rect = CGRect(x: 30, y: 70, width: 300, height: 180)
        let textView = TextViewManager(frame: rect)
        
        textView.allowsEditingTextAttributes = false
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.textColor = gInvalidItemBorderColor
        textView.font = UIFont(name: "Verdana", size: 16)
        self.errorsList = textView
        self.view.addSubview(textView)
        self.additionalField.placeholder = "Confirm Email"
        self.additionalField.keyboardType = .emailAddress
    }
    
    //MARK: UI_TEXT_FIELD DELEGATE
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if textField == self.userNameField && text.characters.count > 2 {
            weak var weakSelf = self
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: text)
            query.findObjectsInBackground(block: { (objects, error) in
                let strongSelf = weakSelf
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let names = objects {
                    
                    if names.count == 0 {
                        textField.layer.borderColor = gValidItemBorderColor.cgColor
                        textField.layer.borderWidth = gBorderWidthDefault
                    }
                    else if names.count > 0 {
                        textField.layer.borderWidth = gBorderWidthDefault
                        textField.layer.borderColor = gInvalidItemBorderColor.cgColor
                        //let issue = SignupIssue(withText: "Username is not available", withType: )
                        let issue = SignupIssue(withText: "Username is not available", withType: .nameTaken)
                        //TODO: weakself
                        strongSelf?.errorsList.addIssue(issue: issue)
                    }
                }
            })
        }
    }
        
    func textFieldDidChange(textField: UITextField) {
        
        guard let text = textField.text else {return}
        
        //password
        if textField == self.passwordField {
            if text.characters.count < 7 && text.characters.count > 0 {
                textField.layer.borderColor = gInvalidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                let issue = SignupIssue(withText: "Password must be at least 7 characters", withType: .passwordShort)
                errorsList.addIssue(issue: issue)
            }
            else if text.characters.count > 6 {
                textField.layer.borderColor = gValidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .passwordShort)
            }
            else {
                textField.layer.borderColor = gNoramlBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .passwordShort)
            }
            
            //username
        } else if textField == self.userNameField {
            errorsList.removeIssue(forType: .nameTaken)
            if text.characters.count < 3 && text.characters.count > 0 {
                textField.layer.borderColor = gInvalidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                let issue = SignupIssue(withText: "Username must be at least 3 letters", withType: .userNameShort)
                errorsList.addIssue(issue: issue)
            } else {
                textField.layer.borderColor = gNoramlBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .userNameShort)
            }
            //email
        } else if textField == self.emailField {
            
            if !validateEmail(candidate: text) && text.characters.count > 0 {
                textField.layer.borderColor = gInvalidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                let issue = SignupIssue(withText: "Not a valid email", withType: .emailFormat)
                errorsList.addIssue(issue: issue)
            } else if validateEmail(candidate: text) {
                textField.layer.borderWidth = gBorderWidthDefault
                textField.layer.borderColor = gValidItemBorderColor.cgColor
                errorsList.removeIssue(forType: .emailFormat)
            }
            else {
                textField.layer.borderColor = gNoramlBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .emailFormat)
            }
            
            //confirm email
        } else if textField == self.additionalField {
            if text != self.emailField.text && text.characters.count > 0 {
                textField.layer.borderColor = gInvalidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                let issue = SignupIssue(withText: "Email fields do not match", withType: .emailMismatch)
                errorsList.addIssue(issue: issue)
            } else if text == self.emailField.text && text.characters.count > 0{
                textField.layer.borderColor = gValidItemBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .emailMismatch)
            }
            else {
                textField.layer.borderColor = gNoramlBorderColor.cgColor
                textField.layer.borderWidth = gBorderWidthDefault
                errorsList.removeIssue(forType: .emailMismatch)
            }
        }
    }
}
