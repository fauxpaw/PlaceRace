//
//  Minimap.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/10/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import MapKit

class Minimap: MKMapView {

    var defaultSize = CGSize()
    var defaultCenter = CGPoint()
    var expanded = false
    
    func setup() {
        self.showsCompass = false
        self.showsTraffic = false
        self.showsScale = false
        self.showsBuildings = false
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.userTrackingMode = .followWithHeading
        self.defaultSize = self.bounds.size
        self.defaultCenter = self.center
        self.tapGesture()
    }
    
    func expand() {
        print("Expanding!")
        self.defaultSize = self.bounds.size
        self.bounds.size = CGSize(width: gScreenWidth - 50, height: gScreenHeight - 200)
        self.center = CGPoint(x: gScreenWidth/2, y: gScreenHeight/2)
        self.expanded = true
    }
    
    func minimize() {
        print("Collapsing")
        self.bounds.size = self.defaultSize
        self.center = self.defaultCenter
        self.expanded = false
    }
    
    func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if self.expanded {
            self.minimize()
        } else {
            self.expand()
        }
    }
    
}
