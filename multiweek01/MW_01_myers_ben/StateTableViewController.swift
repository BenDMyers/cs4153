//
//  StateTableViewController.swift
//  MW_01_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/18/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit
import AVFoundation

class StateTableViewController: UITableViewController {
    
    var states = [
        [
            (name: "Alabama", nickname: "Yellowhammer State", plate: "https://www.ricksplates.com/candids/al/al2015pass.jpg", color: UIColor.white),
            (name: "Alaska", nickname: "The Last Frontier", plate: "https://www.ricksplates.com/candids/ak/ak2016pass.jpg", color: UIColor.white),
            (name: "Arizona", nickname: "Grand Canyon State", plate: "https://www.ricksplates.com/images/archive/az2015pass.jpg", color: UIColor.white),
            (name: "Arkansas", nickname: "The Natural State", plate: "https://www.ricksplates.com/candids/ar/ar2009pass.jpg", color: UIColor.white)
        ],
        [
            (name: "California", nickname: "The Golden State", plate: "https://www.ricksplates.com/othersimgs/kretschmer-d/ca2014pass.jpg", color: UIColor.white),
            (name: "Colorado", nickname: "The Centennial State", plate: "https://www.ricksplates.com/images/archive/co2005pass.jpg", color: UIColor.white),
            (name: "Connecticut", nickname: "Constitution State", plate: "https://www.ricksplates.com/candids/ct/ct-und-fade-pass-v4.jpg", color: UIColor.white)
        ],
        [
            (name: "Delaware", nickname: "The First State", plate: "https://www.ricksplates.com/candids/de/de2011pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Florida", nickname: "The Sunshine State", plate: "https://www.ricksplates.com/images/archive/fl2016pass-ss.jpg", color: UIColor.white)
        ],
        [
            (name: "Georgia", nickname: "The Peach State", plate: "https://www.ricksplates.com/images/archive/ga2016pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Hawaii", nickname: "The Aloha State", plate: "https://www.ricksplates.com/images/archive/hi2008pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Idaho", nickname: "The Gem State", plate: "https://www.ricksplates.com/candids/id/id2010pass.jpg", color: UIColor.white),
            (name: "Illinois", nickname: "Prarie State", plate: "https://www.ricksplates.com/candids/il/il2018pass-new-ver2.jpg", color: UIColor.white),
            (name: "Indiana", nickname: "The Hoosier State", plate: "https://www.ricksplates.com/images/in/in2013opt-igwt.jpg", color: UIColor.white),
            (name: "Iowa", nickname: "The Hawkeye State", plate: "https://www.ricksplates.com/candids/ia/ia2014pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Kansas", nickname: "The Sunflower State", plate: "https://www.ricksplates.com/candids/ks/ks2010pass.jpg", color: UIColor.white),
            (name: "Kentucky", nickname: "The Bluegrass State", plate: "https://www.ricksplates.com/candids/ky/ky2009pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Louisiana", nickname: "The Pelican State", plate: "https://www.ricksplates.com/otherspl8s/oconnor/la2016pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Maine", nickname: "The Pine Tree State", plate: "https://www.ricksplates.com/images/me/me2010pass-rk.jpg", color: UIColor.white),
            (name: "Maryland", nickname: "The Old Line State", plate: "https://www.ricksplates.com/images/md/md2018pass-new.jpg", color: UIColor.white),
            (name: "Massachusetts", nickname: "The Bay State", plate: "https://www.ricksplates.com/images/ma/ma2018pass-rk.jpg", color: UIColor.white),
            (name: "Michigan", nickname: "The Great Lakes State", plate: "https://www.ricksplates.com/candids/mi/mi2014pass.jpg", color: UIColor.white),
            (name: "Minnesota", nickname: "The North Star State", plate: "https://www.ricksplates.com/images/archive/mn2012pass.jpg", color: UIColor.white),
            (name: "Mississippi", nickname: "The Magnolia State", plate: "https://www.ricksplates.com/images/archive/ms2014pass.jpg", color: UIColor.white),
            (name: "Missouri", nickname: "The Show Me State", plate: "https://www.ricksplates.com/images/archive/mo2013pass.jpg", color: UIColor.white),
            (name: "Montana", nickname: "The Treasure State", plate: "https://www.ricksplates.com/candids/mt/mt2012pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Nebraska", nickname: "The Cornhusker State", plate: "https://www.ricksplates.com/candids/ne/ne2018pass-metro.jpg", color: UIColor.white),
            (name: "Nevada", nickname: "The Silver State", plate: "https://www.ricksplates.com/othersimgs/simmons/nv2018pass.jpg", color: UIColor.white),
            (name: "New Hampshire", nickname: "The Granite State", plate: "https://www.ricksplates.com/images/archive/nh2004pass.jpg", color: UIColor.white),
            (name: "New Jersey", nickname: "The Garden State", plate: "https://www.ricksplates.com/candids/nj/nj-und-pass-yellow7.jpg", color: UIColor.white),
            (name: "New Mexico", nickname: "The Land of Enchantment", plate: "https://www.ricksplates.com/candids/nm/nm2015pass.jpg", color: UIColor.white),
            (name: "New York", nickname: "The Empire State", plate: "https://www.ricksplates.com/candids/ny/ny2010s-pass.jpg", color: UIColor.white),
            (name: "North Carolina", nickname: "The Tar Heel State", plate: "https://www.ricksplates.com/candids/nc/nc2016pass-new.jpg", color: UIColor.white),
            (name: "North Dakota", nickname: "The Peace Garden State", plate: "https://www.ricksplates.com/candids/nd/nd2017pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Ohio", nickname: "The Buckeye State", plate: "https://www.ricksplates.com/images/oh/oh2014pass.jpg", color: UIColor.white),
            (name: "Oklahoma", nickname: "The Sooner State", plate: "https://www.ricksplates.com/candids/ok/ok2018pass.jpg", color: UIColor.white),
            (name: "Oregon", nickname: "The Beaver State", plate: "https://www.ricksplates.com/images/archive/or2010pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Pennsylvania", nickname: "The Keystone State", plate: "https://www.ricksplates.com/candids/pa/pa2018pass-ver2.jpg", color: UIColor.white)
        ],
        [
            (name: "Rhode Island", nickname: "The Ocean State", plate: "https://www.ricksplates.com/candids/ri/ri2008pass.jpg", color: UIColor.white)
        ],
        [
            (name: "South Carolina", nickname: "The Palmetto State", plate: "https://www.ricksplates.com/candids/sc/sc2017pass.jpg", color: UIColor.white),
            (name: "South Dakota", nickname: "Mount Rushmore State", plate: "https://www.ricksplates.com/candids/sd/sd2017pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Tennessee", nickname: "The Volunteer State", plate: "https://www.ricksplates.com/images/archive/tn2010pass.jpg", color: UIColor.white),
            (name: "Texas", nickname: "The Lone Star State", plate: "https://www.ricksplates.com/images/archive/tx-und-classic-pass.jpg", color: UIColor.white)
        ],
        [
            (name: "Utah", nickname: "The Beehive State", plate: "https://www.ricksplates.com/images/archive/ut2010pass-ski.jpg", color: UIColor.white)
        ],
        [
            (name: "Vermont", nickname: "The Green Mountain State", plate: "https://www.ricksplates.com/candids/vt/vt2015pass.jpg", color: UIColor.white),
            (name: "Virginia", nickname: "The Old Dominion State", plate: "https://www.ricksplates.com/candids/va/va2016pass-new.jpg", color: UIColor.white)
        ],
        [
            (name: "Washington", nickname: "The Evergreen State", plate: "https://www.ricksplates.com/candids/wa/wa2016pass.jpg", color: UIColor.white),
            (name: "West Virginia", nickname: "The Mountain State", plate: "https://www.ricksplates.com/candids/wv/wv2017pass.jpg", color: UIColor.white),
            (name: "Wisconsin", nickname: "The Badger State", plate: "https://www.ricksplates.com/images/archive/wi2011pass.jpg", color: UIColor.white),
            (name: "Wyoming", nickname: "The Equality State", plate: "https://www.ricksplates.com/candids/wy/wy2010pass.jpg", color: UIColor.white)
        ],
    ]
    
    // Tracks how many states' plates have been found
    var score = 0

    // Displays how many states' plates have currently been found
    var scoreLabel: UIBarButtonItem!
    
    // Audio player
    var audio: AVAudioPlayer?
    
    // Displays alert confirming game reset, and then resets the game
    @IBAction func resetGame(_ sender: UIBarButtonItem) {
        
        let confirmReset = UIAlertController(title: "Reset Game?", message: "Are you sure you would like to reset your game? This cannot be undone.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
            (result : UIAlertAction) in
            for (outerIndex, _) in self.states.enumerated() {
                    for (innerIndex, _) in self.states[outerIndex].enumerated() {
                        self.states[outerIndex][innerIndex].color = UIColor.white
                }
                self.score = 0
                self.scoreLabel.title = "Score: 0 / 50"
                self.playSound(soundName: "fanfare", soundExtension: "mp3")
            }
            self.tableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        confirmReset.addAction(yesAction)
        confirmReset.addAction(noAction)
        
        self.present(confirmReset, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playSound(soundName: "fanfare", soundExtension: "mp3")
        
        // Toolbar magic
        navigationController?.setToolbarHidden(false, animated: true)
        
        let scoreLabel = UIBarButtonItem(title: "Score: 0 / 50", style: .plain, target: self, action: nil)
        
        scoreLabel.tintColor = UIColor.black
        self.scoreLabel = scoreLabel
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let resetButton = UIBarButtonItem(title: "Reset Game", style: .plain, target: self, action: #selector(resetGame(_:)))
        resetButton.tintColor = UIColor.red
        
        self.toolbarItems = [scoreLabel, flex, resetButton]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return states.count
    }

    // Prepare sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return states[section].count
    }

    // Populate cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath)

        cell.textLabel?.text = states[indexPath[0]][indexPath[1]].name
        
        cell.detailTextLabel?.text = states[indexPath[0]][indexPath[1]].nickname
        
        cell.backgroundColor = states[indexPath[0]][indexPath[1]].color
        
        

        return cell
    }
    
    // Divvy up states table into sections by first letter
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(self.states[section][0].name[self.states[section][0].name.startIndex])
    }
    
    // State tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // State not yet found -- make found
        if(states[indexPath[0]][indexPath[1]].color == UIColor.white) {
            playSound(soundName: "ding", soundExtension: "mp3")
            states[indexPath[0]][indexPath[1]].color = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.0)
            score += 1
            scoreLabel.title = "Score: \(score) / 50"
            self.tableView.reloadData()
            
            // Win condition
            if(score == 50) {
                playSound(soundName: "ohyeah", soundExtension: "wav")
                let winAlert = UIAlertController(title: "You Win!", message: "Congratulations! You found all 50 states' plates!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Mine is the glory!", style: .cancel, handler: nil)
                winAlert.addAction(okAction)
                self.present(winAlert, animated: true, completion: nil)
            }
        }
        // State already found -- make unfound
        else {
            let confirmResetState = UIAlertController(title: "Mark State as Unfound?", message: "Are you sure you would like to reset this state?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
                (result : UIAlertAction) in
                    self.states[indexPath[0]][indexPath[1]].color = .white
                    self.score -= 1
                    self.scoreLabel.title = "Score: \(self.score) / 50"
                    self.tableView.reloadData()
                    self.playSound(soundName: "sadbump", soundExtension: "wav")
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            confirmResetState.addAction(yesAction)
            confirmResetState.addAction(noAction)
            
            self.present(confirmResetState, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlateViewController {
            if let send = sender as? UITableViewCell {
                destination.state = (send.textLabel?.text)!
                destination.plateURL = getURLByName(name: (send.textLabel?.text)!)!
            }
        }
    }
    
    // Given a state's name, find its license plate URL
    func getURLByName(name: String) -> String? {
        for (outerIndex, _) in states.enumerated() {
            for (innerIndex, _) in states[outerIndex].enumerated() {
                if(states[outerIndex][innerIndex].name == name) {
                    return states[outerIndex][innerIndex].plate
                }
            }
        }
        return ""
    }
    
    // Enables view controller responding to touch events
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    // Play a given sound
    func playSound(soundName: String, soundExtension: String) {
        guard let soundpath = Bundle.main.url(forResource: soundName, withExtension: soundExtension) else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            audio = try AVAudioPlayer(contentsOf: soundpath)
            guard let audio = audio else {return}
            audio.prepareToPlay()
            audio.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
