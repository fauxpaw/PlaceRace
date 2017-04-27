//
//  CreateGameViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/5/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class CreateGameViewController: UITableViewController, CLLocationManagerDelegate  {
    
    let locManager = CLLocationManager()
    var publicGame = true
    var desiredNumberOfPlayers: Int = 4
    var desiredNumberOfLocations: Int = 6
    var timelimit = false
    var powerUpsEnabled = true
    var currentLoc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    var playFieldCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    var playRadius = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        //self.tableView.separatorStyle = .none
        self.setupLocation()
        
    }
    
    func setupLocation() {
        self.locManager.delegate = self
        self.locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLoc = locations[0].coordinate
        self.playFieldCenter = locations[0].coordinate
        self.locManager.stopUpdatingLocation()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 || indexPath.row == 2 {
            return 120
        }
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: GameSettingPublicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "publicCell", for: indexPath) as! GameSettingPublicTableViewCell
            cell.owningVC = self
            return cell
        }
            
        if indexPath.row == 1 {
            let cell:GameSettingPlayerCountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "playerCountCell", for: indexPath) as! GameSettingPlayerCountTableViewCell
            cell.owningVC = self
            return cell
        }
        
        if indexPath.row == 2 {
            let cell: GameSettingLocationCountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "locationCountCell", for: indexPath) as! GameSettingLocationCountTableViewCell
            cell.owningVC = self
            return cell
        }
        
        if indexPath.row == 3 {
            let cell: GameSettingTimeLimitTableViewCell = tableView.dequeueReusableCell(withIdentifier: "timeLimitCell", for: indexPath) as! GameSettingTimeLimitTableViewCell
            cell.owningVC = self
            return cell
        }

            
        if indexPath.row == 4 {
            let cell: GameSettingPowerupsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "powerUpsCell", for: indexPath) as! GameSettingPowerupsTableViewCell
            cell.owningVC = self
            return cell
        }
            
        if indexPath.row == 5 {
            let cell: GameSettingPlayFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "playFieldCell", for: indexPath) as! GameSettingPlayFieldTableViewCell
            cell.owningVC = self
            return cell
        }
        else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "yourMom")
           return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    @IBAction func nextButtonSelected(_ sender: UIBarButtonItem) {
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "specifyPlayfield" {
            let target = segue.destination as! CreatePlayAreaViewController
            target.createGameVC = self
        }
        
        if segue.identifier == "toGameLobby" {
            //TODO: Create Game object and send to server
            
            print("Public game = \(publicGame)" )
            print("#of Players = \(desiredNumberOfPlayers)")
            print("#of Locations = \(desiredNumberOfLocations)")
            print("Time limit = \(timelimit)")
            print("Powerups = \(powerUpsEnabled)")
            print("Playfield Center = \(playFieldCenter)")
            print("Playfield Radius = \(playRadius)")
            
            let lat = CLLocationDegrees(playFieldCenter.latitude)
            let lng = CLLocationDegrees(playFieldCenter.longitude)
            let loc = CLLocation(latitude: lat, longitude: lng)
            
            /*factory.createNearbyPlaces(centerPoint: loc, radius: playRadius, handler: { (places) in
                for item in places {
                    item.description()
                }
            }) */
            
            PlacesAPI.shared.getPlaces(nearLocation: loc, radius: self.playRadius, handler: { (rootDic, error) in
                
                if let error = error {
                    print("could not get valid JSON root object. check \(error.localizedDescription)")
                }
                
                if let dic = rootDic {
                    guard let array = JSONParser.dictionaryRootToArrayOfDict(rootObj: dic, key: "results") else {return}
                    
                    var results = ObjectiveFactory.shared.createObjectives(fromArrayOfDict: array)
                    //print(RouteCreator.shared.getNewValidRoute(input: &results))
                    print(RouteCreator.shared.evaluateNewList(input: &results))
                }
            })
            
            
            let target = segue.destination as! GameLobbyViewController
            target.gameSettings = self
            if let user = PFUser.current() {
                target.host = user
            }
        }
    }
}

