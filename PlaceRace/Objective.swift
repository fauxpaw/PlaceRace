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
    var coordinates: CLLocationCoordinate2D
    var completed : Bool
    
    init? (json: [String: Any]) {
    
        guard let geoDict = json["geometry"] as? [String: Any]  else {print("geoDict not found");return nil }
        guard let locDict = geoDict["location"] as? [String: Any] else {print("locDict not found");return nil}
    
        if let locName = json["name"] as? String, let latitude = locDict["lat"] as? CLLocationDegrees, let longitude = locDict["lng"] as? CLLocationDegrees {
            let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.coordinates = loc
            self.completed = false
            self.name = locName
            self.completed = false
        } else {
            print("could not instantiate objective. An 'if let' failed")
            return nil
        }
    }
    
    func getCLLocation() -> CLLocation {
        let lat = CLLocationDegrees(self.coordinates.latitude)
        let lng = CLLocationDegrees(self.coordinates.longitude)
        let loc = CLLocation(latitude: lat, longitude: lng)
        return loc
    }
    
    func description() {
        print("My place name is: \(self.name), whose coords are \(self.coordinates) and status is \(self.completed). ")
    }
    
    func dataAsDictionary() -> [String: Any] {
        var dic = Dictionary<String, Any>()
        dic["name"] = self.name
        dic["lat"] = coordinates.latitude
        dic["lng"] = coordinates.longitude
        dic["completed"] = false
        return dic
    }
}
