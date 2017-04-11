//
//  LobbyInteractionClearanceLevel.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/9/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

enum LobbyInteractionClearanceLevel {
    case Host
    case Joinee
}

enum TargetPlayerCellStatus {
    case emptyCell
    case otherPlayersCell
    case owningPlayersCell
}
