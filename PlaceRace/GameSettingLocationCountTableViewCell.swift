//
//  GameSettingLocationCountTableViewCell.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/6/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class GameSettingLocationCountTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var owningVC: CreateGameViewController? {
        didSet {
            self.pickerView.selectRow(owningVC!.desiredNumberOfLocations - 1, inComponent: 0, animated: false)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        let desiredLocations: Int
        desiredLocations = owningVC != nil ? ((owningVC?.desiredNumberOfLocations)! - 1) : 3
        self.pickerView.selectRow(desiredLocations, inComponent: 0, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gMaxLocationsPerGame
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let vc = self.owningVC {
            if row + 1 != vc.desiredNumberOfLocations {
                vc.desiredNumberOfLocations = row + 1
            }
        }
        else {
            print("Picker row selection fallthrough, no value for owning VC")
        }
    }
}
