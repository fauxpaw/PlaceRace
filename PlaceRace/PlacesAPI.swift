//
//  PlacesAPI.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/17/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import CoreLocation

class PlacesAPI {
    
    let apiURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = "AIzaSyCyK0N0v5-vHQ9FrMSpxGorkb42k9QUdQk"
    
    func getPlaces(fromEpicenter location: CLLocation, radius: Int, handler: @escaping (NSDictionary?, NSError?) -> Void)
    
}
