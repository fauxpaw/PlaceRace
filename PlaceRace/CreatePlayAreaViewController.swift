//
//  CreatePlayAreaViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/6/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import MapKit


class CreatePlayAreaViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusInputField: UITextField!
    let radiusMaxDigitLength = 4
    var radius: Int = 1000
    let locationManager = CLLocationManager()
    var managerCanUpdate = false
    var usersLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    var currentEpicenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)) {
        didSet {
            self.zoomMapToRadiusBounds()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
        self.setupLongPressGesture()
        self.setupKeyboardStuff()
        mapView.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.toggleLocationUpdate()
    }
    
    func getUserLocation() -> CLLocationCoordinate2D {
        return (mapView.userLocation.location?.coordinate)!
    }
    
    func toggleLocationUpdate() {
        if self.managerCanUpdate{
            self.locationManager.stopUpdatingLocation()
            self.locationManager.stopUpdatingHeading()
            self.managerCanUpdate = false
        } else {
            self.locationManager.startUpdatingLocation()
            self.managerCanUpdate = true
        }
    }
    
    func zoomMapToRadiusBounds() {
        
        let region = MKCoordinateRegionMakeWithDistance(self.currentEpicenter, CLLocationDistance(self.radius), CLLocationDistance(self.radius))
        //mapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
        
    }
    
    func centerMapOnCurrentLocation () {
        
    }
    
    func applyOverlayToMap() {
        //let overlay = MKCircle(center: <#T##CLLocationCoordinate2D#>, radius: <#T##CLLocationDistance#>)
    }
    
    func clearAllAnnotations() {
        //self.mapView.removeAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
    }
    
    func dropPinAtPress() {
        self.clearAllAnnotations()
        
        self.applyOverlayToMap()
    }
    
    //MARK: TEXTFIELD DELEGATE
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textLength = textField.text {
            if textLength.characters.count < radiusMaxDigitLength {
                return true
            } else {
                return false
            }
        }
        
        return false
    }
    //MARK: KEYBOARD SHENANIGANS
    
    func setupKeyboardStuff() {
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(CreatePlayAreaViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(CreatePlayAreaViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        
        
        UIView.animate(withDuration: 0.25, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.frame = CGRect(x: 0, y: (self.view.frame.origin.y - keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
        //CGRect(x: 0, y: (self.mapView.frame.origin.y - keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        
        UIView.animate(withDuration: 0.25, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.frame = CGRect(x: 0, y: (self.view.frame.origin.y + keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    
    //MARK: LOCATION MANAGER DELEGATE
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("CLmang did up loc")
        self.currentEpicenter = locations[0].coordinate
        self.toggleLocationUpdate()
    }
    
    //tap gesture
    
    func setupLongPressGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        gesture.minimumPressDuration = 1
        self.mapView.addGestureRecognizer(gesture)
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        self.dropPinAtPress()
    }
}
