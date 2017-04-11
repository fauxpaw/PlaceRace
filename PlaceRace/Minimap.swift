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

    var expanded = false
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setup() {
        self.showsCompass = false
        self.showsTraffic = false
        self.showsScale = false
        self.showsBuildings = false
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.tapGesture()
    }
    
    func drawPlayerPath() {
        
    }
    
    func syncronize() {
        
    }
    
    func expand() {
        print("Expanding!")
        self.expanded = true
    }
    
    func minimize() {
            print("Collapsing")
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
