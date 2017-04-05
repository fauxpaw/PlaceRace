//
//  ViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/3/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainMenuViewController: UIViewController, PFLogInViewControllerDelegate {

    var loginVC = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.login()
    }

    fileprivate func login(){
        
        if (PFUser.current() == nil) {
            
            loginVC.fields = [PFLogInFields.usernameAndPassword, PFLogInFields.logInButton, PFLogInFields.signUpButton, PFLogInFields.dismissButton, .facebook]
            loginVC.signUpController = SignupViewController()
            loginVC.signUpController?.fields = [.default, .additional]
            //TODO: PFLogInFields.passwordForgotten
            loginVC.delegate = self
            loginVC.signUpController?.delegate = loginVC
            self.present(loginVC, animated: true, completion: nil)
            
        } else {
            print("User is logged in")
        }
    }
    
    //MARK: PF_LOGIN_DELEGATE
    
    public func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    public func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: Error?) {
        
        if let error = error {
            let alertController = UIAlertController(title: "Pet Pageant", message: "Login failed - \(error.localizedDescription)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            self.loginVC.present(alertController, animated: true, completion: nil)
        }
    }

    
    
}

