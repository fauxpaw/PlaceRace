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

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var object = PFObject(className: "TestClass")
        object.add("Banana", forKey: "favoriteFood")
        object.add("Chocolate", forKey: "favoriteIceCream")
        object.saveInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

