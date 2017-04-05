//
//  LoginViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/4/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import ParseUI

class LoginViewController: PFLogInViewController, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func signUpViewController(_ signUpController: PFSignUpViewController, shouldBeginSignUp info: [String : String]) -> Bool {
        
        guard let name = self.signUpController?.signUpView?.usernameField?.text else {return false}
        guard let password = self.signUpController?.signUpView?.passwordField?.text else {return false}
        guard let email = self.signUpController?.signUpView?.emailField?.text else {return false}
        guard let confirm = self.signUpController?.signUpView?.additionalField?.text else {return false}
        
        //TODO: ACTION SHEET THIS BROSEF
        var error = false
        var message = ""
        
        if name.characters.count < 1 || password.characters.count < 1 || email.characters.count < 1 {
            message = "All fields must be filled in"
            error = true
        }
        
        if name.characters.count < 3 && name.characters.count > 0   {
            message = "Invalid username, must be at least 3 letters long"
            error = true
        }
        if password.characters.count < 7 && password.characters.count > 0 {
            message = "Invalid password, must be at least 7 characters"
            error = true
        }
        if !validateEmail(candidate: email) {
            message = "Invalid email, must contain a valid domain"
            error = true
        }
        
        if email != confirm {
            message = "Email fields must match"
            error = true
        }
        
        if error {
            let controller = UIAlertController(title: "PlaceRace", message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.signUpController?.present(controller, animated: true, completion: nil)

            return false
        }
        
        //TODO: Test for email matching!!!!!!!
        
        return true
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(_ signUpController: PFSignUpViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didFailToSignUpWithError error: Error?) {
        //TODO: ACTION SHEET
        guard let error = error else { return }
        let controller = UIAlertController(title: "PlaceRace", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.signUpController?.present(controller, animated: true, completion: nil)
    }
}
