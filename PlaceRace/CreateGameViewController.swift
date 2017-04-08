//
//  CreateGameViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/5/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class CreateGameViewController: UITableViewController  {
    
    var publicGame = true
    var desiredNumberOfPlayers: Int = 4
    var desiredNumberOfLocations: Int = 6
    var timelimit = false
    var powerUpsEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
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
        else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "yourMom")
           return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @IBAction func nextButtonSelected(_ sender: UIBarButtonItem) {
        
        print("Public game = \(publicGame)" )
        print("#of Players = \(desiredNumberOfPlayers)")
        print("#of Locations = \(desiredNumberOfLocations)")
        print("Time limit = \(timelimit)")
        print("Powerups = \(powerUpsEnabled)")
        
        self.performSegue(withIdentifier: "specifyPlayfield", sender: self)
        
    }
}
