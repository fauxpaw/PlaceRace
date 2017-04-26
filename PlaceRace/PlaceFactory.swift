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
        
        
    
    }
    
    func createPlacesFromArrayOfDictionaries() {
        
    }

}
