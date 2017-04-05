//
//  SignupIssue.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/4/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class SignupIssue {
    
    var text: String
    var type: IssueType
    
    init(withText text: String, withType type: IssueType) {
        self.text = text
        self.type = type
    }
}

enum IssueType {
    case nameTaken
    case emailMismatch
    case passwordShort
    case userNameShort
    case emailFormat
}
