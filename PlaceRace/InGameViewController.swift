//
//  InGameViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/10/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import MapKit

class InGameViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: Gamemap!
    @IBOutlet weak var mini_map: Minimap!
    var lastHeading: CLLocationDirection = CLLocationDirection(integerLiteral: 24)
    var lastLoc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 7.748738694980503, longitude: -122.30575994599825)
    var lastAlt: CLLocationDistance = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mini_map.setup()
        self.mapView.setup()
        self.mini_map.delegate = self
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        //self.mapView.delegate = self
        // Do any additional setup after loading the view.
        let anno = UserAnnotation(title: "Titlez", subtitle: "subin", coordinate: lastLoc, pinColor: UIColor.purple)
        
        self.mapView.addAnnotation(anno)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("Mapview going ham?")
        self.mapView.camera.altitude = self.mapView.lastKnownAlt
        self.mapView.camera.centerCoordinate = self.mapView.lastKnownUserLoc
        self.mapView.camera.heading = self.mapView.lastKnownHeading
        self.mapView.camera.pitch = 80
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if lastAlt == self.mapView.lastKnownAlt && lastLoc.latitude == self.mapView.lastKnownUserLoc.latitude && lastLoc.longitude == self.mapView.lastKnownUserLoc.longitude && lastHeading == self.mapView.lastKnownHeading {return}
        print("Mapview region will change!")

        self.mapView.camera.altitude = self.mapView.lastKnownAlt
        self.mapView.camera.centerCoordinate = self.mapView.lastKnownUserLoc
        self.mapView.camera.heading = self.mapView.lastKnownHeading
        self.mapView.camera.pitch = 80
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Mapview rendering!")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("map loaded!")
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("map soon to load")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("did finish rendering map!")
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if mapView == self.mapView {
            if annotation.isEqual(mapView.userLocation)  {
                let anoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "user")
                anoView.pinTintColor = UIColor.purple
                
                return anoView
            }
        }
        
        return nil
    }
    
}
