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
        
        print("Signup checking.......")
        
        guard let name = self.signUpController?.signUpView?.usernameField?.text else {return false}
        guard let password = self.signUpController?.signUpView?.passwordField?.text else {return false}
        guard let email = self.signUpController?.signUpView?.emailField?.text else {return false}
        
        //TODO: ACTION SHEET THIS BROSEF
        if name.characters.count < 1 || password.characters.count < 1 || email.characters.count < 1 {
            print("All fields must be filled in")
            return false
        }
        
        if name.characters.count < 3 && name.characters.count > 0   {
            print("Invalid username, must be at least 3 letters long")
            return false
        }
        if password.characters.count < 7 && password.characters.count > 0 {
            print("Invalid password, must be at least 7 characters")
            return false
        }
        if !validateEmail(candidate: email) {
            print("Invalid email, must contain a valid domain")
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
        print(error.localizedDescription)
        
    }
    
    
}
