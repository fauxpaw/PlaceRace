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
    
    func createNearbyPlaces(centerPoint: CLLocation, radius: Int) -> [Objective] {
        
        var places = [Objective]()
        
        if !loadingInProgress {
            loadingInProgress = true
            let loader = PlacesAPI()
            
            //MOVE THIS API CALL TO A CONTROLLER
            loader.getNearbyPlaces(fromEpicenter: centerPoint, radius: radius, handler: { (placesDict, error) in
                if let dict = placesDict {
                    //print(dict)
                    guard let placesArray = dict.object(forKey: "results") as? [[String:Any]] else {return}
                    for placeDictionary in placesArray {
                        //pull out the various keys
                        //let lat = placeDictionary.value(forKeyPath: "geometry.location.lat") as! CLLocationDegrees
                        //let long = placeDictionary.value(forKeyPath: "geometry.location.lng") as! CLLocationDegrees
                        //let reference = placeDictionary.object(forKey: "reference") as! String
                        //let name = placeDictionary.object(forKey: "name") as! String
                        // let vicinity = placeDictionary.object(forKey: "vicinity") as! String
                        //let types = placeDictionary.object(forKey: "type") as! NSArray
                        
                        //let location = CLLocation(latitude: lat, longitude: long)
                        //let annotation = ObjectiveAnnotation(title: name, coordinate: location.coordinate)
                        if let place = Objective(json: placeDictionary) {
                            places.append(place)
                        }
                        
                        
                        /*DispatchQueue.main.async {
                            
                            self.addAnnotation(annotation)
                        }*/
                    }
                }
            })
        }
        print("Here are the places objects: \(places)")
        return places
    }
    

}
