//
//  PlaceManager.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/20/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceFactory {
    
    //singleton?
    var loadingInProgress = false
    typealias completionHandler = ([Objective])->()
    
    func createNearbyPlaces(centerPoint: CLLocation, radius: Int, handler: @escaping completionHandler) {
        
        var places = [Objective]() 
        
        if !loadingInProgress {
            loadingInProgress = true
            let loader = PlacesAPI()
            
            loader.getPlaces(nearLocation: centerPoint, radius: radius, handler: { (placesDict, error) in
                if let dict = placesDict {
                    //print(dict)
                    guard let placesArray = dict.object(forKey: "results") as? [[String:Any]] else {return}
                    for placeDictionary in placesArray {
                        
                        if let place = Objective(json: placeDictionary) {
                            places.append(place)
                        }
                    }
                    handler(places)
                }
            })
        }
    }
    

}
