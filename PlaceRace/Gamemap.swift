//
//  Gamemap.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/10/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import MapKit

class Gamemap: MKMapView, CLLocationManagerDelegate {

    var lastKnownHeading: CLLocationDirection = CLLocationDirection(integerLiteral: 24)
    var lastKnownAlt: CLLocationDistance = 50
    var lastKnownUserLoc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let clMang = CLLocationManager()
    let playerRoute = [Objective]()
    let userPin = MKPinAnnotationView()
    
    let testObjective = CLLocationCoordinate2D(latitude: 7.748738694980503, longitude: -112.30575994599825)
    
    func setup() {
        //self.userTrackingMode = .followWithHeading
        self.isZoomEnabled = false
        self.isScrollEnabled = false
        self.isRotateEnabled = false
        self.showsCompass = false
        self.clMang.delegate = self
        self.clMang.startUpdatingLocation()
        self.clMang.startUpdatingHeading()
        self.clMang.distanceFilter = 5
        self.clMang.headingFilter = 1

        print(self.camera.pitch)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //set camera altitude
        self.camera.altitude = self.lastKnownAlt
        //set camera heading
        self.camera.heading = self.lastKnownHeading
        //set camera center
        self.camera.centerCoordinate = self.lastKnownUserLoc
        
        self.camera.pitch = 80
        print("Did update locs")
        if let current = locations.last {
            if current.altitude > 0 {
                self.lastKnownAlt = current.altitude + 50
            }
            
            self.lastKnownUserLoc = current.coordinate
            self.lastKnownHeading = current.course
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("did update heading")
        self.lastKnownHeading = newHeading.trueHeading
        self.camera.heading = self.lastKnownHeading
    }
    
    func getAngleToObjective(objective: Objective) -> CLLocationDirection {
        
        let deltaX = (objective.coordinates?.latitude)! - self.lastKnownUserLoc.latitude
        let deltaY = (objective.coordinates?.longitude)! - self.lastKnownUserLoc.longitude
        let thetaRadians = atan2(deltaY, deltaX)
        
        return CLLocationDirection(exactly: fmod(thetaRadians * 180 / M_PI, 360))!
    }
    
    func compareHeadingToObjectiveAngle(objectiveAngle: Double) {
        if self.lastKnownHeading <= CLLocationDirection(objectiveAngle + 10) && self.lastKnownHeading >= CLLocationDirection(objectiveAngle - 10) {
            self.userPin.pinTintColor = UIColor.green
        } else if self.lastKnownHeading <= CLLocationDirection(objectiveAngle + 50) && self.lastKnownHeading >= CLLocationDirection(objectiveAngle - 50) {
            self.userPin.pinTintColor = UIColor.yellow
        } else {
            self.userPin.pinTintColor = UIColor.red
        }
    }
    
    func degreesToRadians (input: Double) -> Double {
       return M_PI * input / 180
    }
    
    func radiansToDegrees(input: Double) -> Double {
        return input * 180 / M_PI
    }
    
    
}
