//
//  UserAnnotation.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/11/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import MapKit

class UserAnnotation: NSObject, MKAnnotation{

    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    var pinColor: UIColor
   
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D ,pinColor: UIColor) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.pinColor = pinColor
    }
}
