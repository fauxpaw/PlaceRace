//
//  TextViewManager.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/4/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit


class TextViewManager: UITextView  {
    
    //TODO: convert data structure to use dictionary for better performance
    
    var signupErrors = [SignupIssue]() {
        didSet {
            self.updateTextView()
        }
    }
    
    func addIssue(issue: SignupIssue) {
        
        for item in signupErrors {
            if item.type == issue.type {
                return
            }
        }
        
       signupErrors.append(issue)
    }
    
    func removeIssue(forType type: IssueType ) {
        for (index, issue) in signupErrors.enumerated() {
            if issue.type == type {
                signupErrors.remove(at: index)
            }
        }
    }
    
    func updateTextView() {
        self.text = ""
        for issue in signupErrors {
            self.text.append(self.formatLineForIssue(withIssue: issue))
        }
    }
    
    func formatLineForIssue(withIssue issue: SignupIssue) -> String {
        let text = issue.text
        let prefix = "\n \u{2022} "
        let suffix = " \n"
        
        return prefix + text + suffix
    }
}
