//
//  mySplashViewController.swift
//  T01_orange
//
//  Created by Tyler Lang on 9/25/17.
//  Copyright © 2017 Brightest Orange. All rights reserved.
//

import UIKit

class mySplashViewController: UIViewController {
    var gMode = 1//1=Standard,2=FreePlay,3=Timed,4=Counted
    var currDiff = 0 //0=easy, 2=hard
    
    //Labels
    @IBOutlet weak var gameModeLabel: UILabel!
    @IBOutlet weak var numPairsLabel: UILabel!
    @IBOutlet weak var numMinsLabel: UILabel!
    //Difficulty Buttons
    @IBOutlet weak var EasyButton: UIButton!
    @IBOutlet weak var NormalButton: UIButton!
    @IBOutlet weak var HardButton: UIButton!
    //GameMode Buttons
    @IBOutlet weak var Mode1Button: UIButton!
    @IBOutlet weak var Mode2Button: UIButton!
    @IBOutlet weak var Mode3Button: UIButton!
    @IBOutlet weak var Mode4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setGameModeLabel()
        updLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //sets indicator of active game mode
    func setGameModeLabel(){
        if gMode == 1{
            gameModeLabel.text = "Standard"
        } else if gMode == 2{
            gameModeLabel.text = "Free Play"
        } else if gMode == 3{
            gameModeLabel.text = "Timed"
        } else if gMode == 4{
            gameModeLabel.text = "Counted"
        }
    }
    
    //calls of the buttons. Sets game mode or difficulty
    @IBAction func M1Press(_ sender: Any) {
        gMode = 1
        setGameModeLabel()
    }
    @IBAction func M2Press(_ sender: Any) {
        gMode = 2
        setGameModeLabel()
    }
    @IBAction func M3Press(_ sender: Any) {
        gMode = 3
        setGameModeLabel()
    }
    @IBAction func M4Press(_ sender: Any) {
        gMode = 4
        setGameModeLabel()
    }
    
    @IBAction func EasySelected(_ sender: Any) {
        currDiff = 0
        updLabels()
    }
    
    @IBAction func NormalSelected(_ sender: Any) {
        currDiff = 1
        updLabels()
    }
    
    @IBAction func HardSelected(_ sender: Any) {
        currDiff = 2
        updLabels()
    }
    func updLabels(){
        numPairsLabel.text = "# of Pairs:\(diffToNumPairs())"
        numMinsLabel.text = "# of Mins\(diffToNumMins())"
    }
    
    //prepares to set gameMode, howManyPairs, and timeLimit in ViewController
    //calls diffToNumPairs and diffToNumMins
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaySegue" {
            if let destination = segue.destination as? ViewController {
                destination.gameMode = gMode
                destination.howManyPairs = diffToNumPairs()
                destination.timeLimit = diffToNumMins()*3600
            }
        }
    }
    
    //does math for setting the move limit and time limit
    func diffToNumPairs() -> Int{
        return (currDiff*2)+4
    }
    func diffToNumMins() -> Int{
        return 3-currDiff
    }

}
