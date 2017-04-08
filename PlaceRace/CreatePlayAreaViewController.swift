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

    var createGameVC: CreateGameViewController?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusInputField: UITextField!
    let radiusMaxDigitLength = 4
    var radius: Int = 1000 {
        didSet {
            self.newOverlay()
            self.createGameVC?.playRadius = self.radius
        }
    }
    
    let locationManager = CLLocationManager()
    var managerCanUpdate = false
    var usersLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)) {
        didSet{
            self.createGameVC?.currentLoc = self.usersLocation
        }
    }
    var currentEpicenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)) {
        didSet {
            self.applyAnnotation()
            self.newOverlay()
            self.createGameVC?.playFieldCenter = self.currentEpicenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.setupMapView()
        self.setupLocationManager()
        self.setupTap()
        self.setupLongPressGesture()
        self.setupKeyboardStuff()
        self.setupTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupMapView() {
        self.mapView.delegate = self
    }
    
    func setupTextField() {
        self.radiusInputField.delegate = self
        self.radiusInputField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 15
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
            self.locationManager.stopUpdatingHeading()
            self.managerCanUpdate = true
        }
    }
    
    func zoomMapToRadiusBounds() {
        
        let region = MKCoordinateRegionMakeWithDistance(self.currentEpicenter, CLLocationDistance(self.radius), CLLocationDistance(Double(self.radius) * 2 + Double(self.radius) * 0.5))
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: OVERLAY METHODS
    func newOverlay() {
        self.clearOverlays()
        self.applyOverlayToMap()
        self.zoomMapToRadiusBounds()
    }
    
    func applyOverlayToMap() {
        let overlay = MKCircle(center: self.currentEpicenter, radius: CLLocationDistance(self.radius))
    
        self.mapView.add(overlay)
    }
    
    func clearOverlays() {
        self.mapView.removeOverlays(self.mapView.overlays)
    }
    
    //MARK: ANNOTATION METHODS
    
    func clearAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
    }
    
    func applyAnnotation() {
        self.clearAnnotations()
        self.createAnnotation()
        self.zoomMapToRadiusBounds()
    }
    
    func createAnnotation() {
        let pin = MKPointAnnotation()
        pin.coordinate = self.currentEpicenter
        pin.title = "Play Area Center"
        //let view = MKPinAnnotationView(annotation: pin, reuseIdentifier: "pin")
        //view.canShowCallout = true
        //view.animatesDrop = true
        mapView.addAnnotation(pin)
    }
    
    //MARK: TEXTFIELD DELEGATE
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let current = textField.text else { return false}
        
        if current.characters.count == radiusMaxDigitLength && string != "" {
                return false
        }
        
        return true
    }
    
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {return}

        if text.characters.count == 0 {
            self.radius = 1000
        } else {
            guard let asInt = Int(text) else {return}
            self.radius = asInt
        }
        print(self.radius)
    }
    
    //MARK: KEYBOARD SHENANIGANS
    
    func setupKeyboardStuff() {
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(CreatePlayAreaViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(CreatePlayAreaViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func hideRadiusInputKeyboard() {
       // self.radiusInputField
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        
        
        UIView.animate(withDuration: 0.25, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.frame = CGRect(x: 0, y: (self.view.frame.origin.y - keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
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
        self.usersLocation = locations[0].coordinate
        self.currentEpicenter = locations[0].coordinate
        self.toggleLocationUpdate()
    }
    
    //tap gesture
    
    func setupLongPressGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        gesture.minimumPressDuration = 1
        self.mapView.addGestureRecognizer(gesture)
    }
    
    func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began{
            let touchPoint = gesture.location(in: self.mapView)
            let coords = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            self.currentEpicenter = coords
        }
    }
    
    func setupTap() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:))))
    }
    
    //MARK: MAPVIEW DELEGATE
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = UIColor.blue.withAlphaComponent(0.4)
        circle.fillColor = UIColor.yellow.withAlphaComponent(0.4)
        return circle
    }
    
}
