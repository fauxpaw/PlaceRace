//
//  InputValidation.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/4/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

let gBorderWidthDefault: CGFloat = 2
let gValidItemBorderColor = UIColor.green
let gInvalidItemBorderColor = UIColor.red
let gNoramlBorderColor = UIColor.clear

func validateEmail(candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
}

