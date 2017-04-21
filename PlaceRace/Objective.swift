//
//  Objective.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/9/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import Parse


class Objective {
    
    var name: String
    //var imgUrl: String?
    //var info: String?
    //var category: String?
    var coordinates: CLLocationCoordinate2D
    var completed : Bool?
    
    /*init(name: String, imgUrl: String, info: String, category: String, coordinates: CLLocationCoordinate2D) {
    }*/
    
    init? (json: [String: Any]) {
    
        guard let geoDict = json["geometry"] as? [String: Any]  else {print("geoDict not found");return nil }
        guard let locDict = geoDict["location"] as? [String: Any] else {print("locDict not found");return nil}
    
        if let locName = json["name"] as? String, let latitude = locDict["lat"] as? CLLocationDegrees, let longitude = locDict["lng"] as? CLLocationDegrees {
            let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.coordinates = loc
            self.completed = false
            self.name = locName
        } else {
            print("could not instantiate objective. An 'if let' failed")
            return nil
        }
    }
}
