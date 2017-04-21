//
//  PlacesAPI.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/17/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import CoreLocation

//WORKFLOW: FETCH
//GET DICTIONARY ROOTOBJECT
//GET ARRAY OF DICTIONARIES
//PARSE EACH DICTIONARY INTO A SEPERATE OBJECT
//STORE OBJECT?

class PlacesAPI {
    
    let apiURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = "AIzaSyCyK0N0v5-vHQ9FrMSpxGorkb42k9QUdQk"
    let nearbySearchString = "nearbysearch/json?location="
    
    //fetch list of places near a specified location

    func getNearbyPlaces(fromEpicenter location: CLLocation, radius: Int, handler: @escaping (NSDictionary?, NSError?) -> Void) {
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let uri = "\(apiURL)\(nearbySearchString)\(latitude),\(longitude)&radius=\(radius)&sensor=true&types=establishment&key=\(apiKey)"
        let url = URL(string: uri)!
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print(data!)
                    
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        guard let responseDict = responseObject as? NSDictionary else {
                            return
                        }
                        handler(responseDict, nil)
                        
                    } catch let error as NSError {
                        handler(nil, error)
                    }
                }
            }
        }
        dataTask.resume()
    }

}
