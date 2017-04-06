//
//  GameSettingTimeLimitTableViewCell.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/6/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class GameSettingTimeLimitTableViewCell: UITableViewCell {

    var owningVC: CreateGameViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onOffButtonToggled(_ sender: UISegmentedControl) {
        if let vc = owningVC {
            let value = sender.selectedSegmentIndex
            if value == 0 {
                vc.timelimit = false
            } else if value == 1 {
                vc.timelimit = true
            }
        }
        else {
            print("No value for owning VC, ON/OFF toggle fallthroug for \(self)")
        }
    }
}
