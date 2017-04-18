//
//  GameLobbyPlayerTableViewCell.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/8/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit

class GameLobbyPlayerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var playerAvatar: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
