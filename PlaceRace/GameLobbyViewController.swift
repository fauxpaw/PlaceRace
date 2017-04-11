//
//  GameLobbyViewController.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/8/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import UIKit
import Parse

class GameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    //var thisPlayer =
    var clearance:LobbyInteractionClearanceLevel = .Joinee
    var host = PFUser()
    var currentPlayers: [PFUser?] = []
    var maxPlayerCount = 4
    var powerUps = true
    var locationsCount = 5
    var publicAccess = true
    var gameSettings: CreateGameViewController = CreateGameViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.identifyPlayer() //replace with get info
        self.addJoinerToPlayersList()
        //TODO: fetch game initial info from server
        //TODO: Handle join collision
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.textView.delegate = self
        //TODO: Cloudcode to push current game state to participants or client code to query every few seconds?
    }
    func addJoinerToPlayersList() {
        if let user = PFUser.current() {
            self.currentPlayers.append(user)
        }
    }
    
    func identifyPlayer() {
        if PFUser.current() == host {
            //print("this player is host: \(PFUser.current())")
            clearance = .Host
        } else {
            //print("this player is joinee")
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.maxPlayerCount
    }

    //MARK: TABLEVIEW DELEGATE
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: GameLobbyPlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "lobbyPlayerCell", for: indexPath) as! GameLobbyPlayerTableViewCell
        
        if indexPath.row < currentPlayers.count {
            if let player = currentPlayers[indexPath.row] {
                cell.playerName.text = player.username
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = UIAlertController(title: "PlaceRace", message: "Menu", preferredStyle: .actionSheet)
        
        guard let player = PFUser.current() else {return}
        
        //target is empty cell
        if indexPath.row >= currentPlayers.count {
            let invite = UIAlertAction(title: "Invite Friend", style: .default, handler: { (action) in
                self.invitePlayer()
            })
            controller.addAction(invite)
        } else {
            if currentPlayers[indexPath.row] == player {
                let leaveGame = UIAlertAction(title: "Leave Game", style: .default, handler: { (action) in
                    self.leaveGame()
                })
                controller.addAction(leaveGame)
            }
            else {
                let block = UIAlertAction(title: "Block User", style: .destructive, handler: { (action) in
                    self.blockPlayer()
                })
                let friendReq = UIAlertAction(title: "Friend Request", style: .default, handler: { (action) in
                    self.sendFriendRequest()
                })
                let checkProf = UIAlertAction(title: "Check Profile", style: .default, handler: { (action) in
                    self.checkPlayersProfile()
                })
                
                switch clearance {
                case .Host:
                    let makeHost = UIAlertAction(title: "Make Host", style: .default, handler: { (action) in
                        self.makePlayerTheHost()
                    })
                    let kickPlayer = UIAlertAction(title: "Kick Player", style: .destructive, handler: { (action) in
                        self.kickPlayerFromLobby()
                    })
                    let banPlayer = UIAlertAction(title: "Ban Player", style: .destructive, handler: { (action) in
                        self.banPlayerFromLobby()
                    })
                    controller.addAction(makeHost)
                    controller.addAction(kickPlayer)
                    controller.addAction(banPlayer)
                    
                default:
                    print("presenting JOINEE menu for target other player")
                    
                }
                controller.addAction(block)
                controller.addAction(friendReq)
                controller.addAction(checkProf)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancel)
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.present(controller, animated: true, completion: nil)

    }
    
    func makePlayerTheHost() {
        
    }
    
    func banPlayerFromLobby() {
        print("Never come back to my game!")
    }
    
    func kickPlayerFromLobby(){
        print("Get outta here ugly player!")
    }
    
    func sendFriendRequest() {
        print("We are now friends!")
    }
    
    func checkPlayersProfile() {
        print("This player has done all the things!")
    }
    
    func blockPlayer() {
        print("Player blocked!")
    }
    
    func invitePlayer() {
        print("inviting player now!")
    }
    
    func leaveGame() {
        //TODO: release player from this game and any resources on app!!!!
    
        self.dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func startGameButtonSelected(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "lobbyToInGame", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lobbyToInGame" {
            print("We are going to game!")
        }
    }
    
}
