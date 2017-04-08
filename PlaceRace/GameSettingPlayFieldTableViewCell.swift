//
//  GameSettingPlayFieldTableViewCell.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/8/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class GameSettingPlayFieldTableViewCell: UITableViewCell {
    var owningVC: CreateGameViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didSelectChooseButton(_ sender: UISegmentedControl) {
        
        if let vc = owningVC {
            let value = sender.selectedSegmentIndex
            if value == 0 {
                print("selecting default for play area")
                vc.playRadius = 1000
                vc.playFieldCenter = vc.currentLoc
            } else if value == 1 {
                vc.performSegue(withIdentifier: "specifyPlayfield", sender: sender)
            }
        }
        else {
            print("No value for owning VC, ON/OFF toggle fallthroug for \(self)")
        }

        
    }
    

}
