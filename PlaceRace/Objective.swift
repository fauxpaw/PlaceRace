//
//  Objective.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/9/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import Parse


struct Objective {
    
    var name: String?
    var imgUrl: String?
    var info: String?
    var category: String?
    var coordinates: CLLocationCoordinate2D?
    var completed = false
    
    /*init(name: String, imgUrl: String, info: String, category: String, coordinates: CLLocationCoordinate2D) {
    }*/
    
}
