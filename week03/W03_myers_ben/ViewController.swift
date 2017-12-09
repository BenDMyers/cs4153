//
//  ViewController.swift
//  W03_myers_ben
//
//  Created by MYERS BENJAMIN D on 9/12/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chords = [
        (name: "A", aFret: 0, eFret: 0, cFret: 1, gFret: 2),
        (name: "B", aFret: 2, eFret: 2, cFret: 3, gFret: 4),
        (name: "C", aFret: 3, eFret: 0, cFret: 0, gFret: 0),
        (name: "D", aFret: 0, eFret: 2, cFret: 2, gFret: 2),
        (name: "E", aFret: 2, eFret: 0, cFret: 4, gFret: 1),
        (name: "F", aFret: 0, eFret: 1, cFret: 0, gFret: 2),
        (name: "G", aFret: 2, eFret: 3, cFret: 2, gFret: 0),
        (name: "Am", aFret: 0, eFret: 0, cFret: 0, gFret: 2),
        (name: "Bm", aFret: 2, eFret: 2, cFret: 2, gFret: 4),
        (name: "Cm", aFret: 3, eFret: 3, cFret: 3, gFret: 0),
        (name: "Dm", aFret: 0, eFret: 1, cFret: 2, gFret: 2),
        (name: "Em", aFret: 2, eFret: 3, cFret: 4, gFret: 0),
        (name: "Fm", aFret: 3, eFret: 1, cFret: 0, gFret: 1),
        (name: "Gm", aFret: 1, eFret: 3, cFret: 2, gFret: 0),
        (name: "A7", aFret: 0, eFret: 0, cFret: 1, gFret: 0),
        (name: "B7", aFret: 2, eFret: 2, cFret: 3, gFret: 2),
        (name: "C7", aFret: 1, eFret: 0, cFret: 0, gFret: 0),
        (name: "D7", aFret: 3, eFret: 2, cFret: 2, gFret: 2),
        (name: "E7", aFret: 2, eFret: 0, cFret: 2, gFret: 1),
        (name: "F7", aFret: 3, eFret: 1, cFret: 3, gFret: 2),
        (name: "G7", aFret: 2, eFret: 1, cFret: 2, gFret: 0)
    ]
    
    // x-coords of strings ([0] is a dummy)
    let stringCoords = [-1, 278, 208, 138, 68]
    
    // y-coords of frets ([0] is a dummy)
    let fretCoords = [-1, 103, 183, 263, 343]
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    @IBOutlet weak var option1: UILabel!
    @IBOutlet weak var option2: UILabel!
    @IBOutlet weak var option3: UILabel!
    @IBOutlet weak var successStatus: UILabel!
    @IBOutlet weak var aDot: UIImageView!
    @IBOutlet weak var eDot: UIImageView!
    @IBOutlet weak var cDot: UIImageView!
    @IBOutlet weak var gDot: UIImageView!
    
    var playMode = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
        playRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sets game back to initial state before a new round
    func resetGame() {
        shuffleChords()
        
        scoreLabel.text = "Score: " + String(score)
        successStatus.isHidden = true
        
        // Move options back to the right place
        option1.center.x = 95
        option1.center.y = 520
        option2.center.x = 187
        option2.center.y = 520
        option3.center.x = 279
        option3.center.y = 520
        
        // Hide all dots for now so that they can be selectively unhidden
        aDot.isHidden = true
        eDot.isHidden = true
        cDot.isHidden = true
        gDot.isHidden = true
        
        // We can now allow the player to play
        playMode = true
    }
    
    // Randomizes chord order so the first three can be used as choices
    // Yes, this is tremendously inefficient
    func shuffleChords() {
        for (i, _) in chords.enumerated() {
            let j = Int(arc4random_uniform(UInt32(chords.count)))
            let temp = chords[j]
            chords[j] = chords[i]
            chords[i] = temp
        }
    }
    
    // Decide on choices and configure fretboard
    // 'chords' has already been randomized
    // chords[0] is the correct answer, [1] and [2] are the two wrong answers
    func playRound() {
        
        // Configure fretboard
        if chords[0].aFret > 0 {
            aDot.isHidden = false
            aDot.frame.origin.y = CGFloat(fretCoords[chords[0].aFret])
        }
        if chords[0].eFret > 0 {
            eDot.isHidden = false
            eDot.frame.origin.y = CGFloat(fretCoords[chords[0].eFret])
        }
        if chords[0].cFret > 0 {
            cDot.isHidden = false
            cDot.frame.origin.y = CGFloat(fretCoords[chords[0].cFret])
        }
        if chords[0].gFret > 0 {
            gDot.isHidden = false
            gDot.frame.origin.y = CGFloat(fretCoords[chords[0].gFret])
        }
        
        // Randomize label order
        var labelOrder = [option1, option2, option3]
        for (i, _) in labelOrder.enumerated() {
            let j = Int(arc4random_uniform(UInt32(labelOrder.count)))
            let temp = labelOrder[j]
            labelOrder[j] = labelOrder[i]
            labelOrder[i] = temp
        }
        labelOrder[0]?.text = chords[0].name
        labelOrder[1]?.text = chords[1].name
        labelOrder[2]?.text = chords[2].name
    }
    
    // User drags one of the options
    @IBAction func makeMove(_ sender: UIPanGestureRecognizer) {
        
        // Don't let user move anything if this round is finished
        if !playMode {
            return
        }
        
        // Commence moving of the label
        let distance = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + distance.x, y: view.center.y + distance.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        // Once user lets go of label, determine whether the user put the right label in the right place
        if sender.state == UIGestureRecognizerState.ended && moveIsWithinFretboard(x: (sender.view?.center.x)!, y: (sender.view?.center.y)!) {
            let label = sender.view as! UILabel
            if label.text == chords[0].name {
                successStatus.text = "Correct!"
                successStatus.isHidden = false
                score += 1
            }
            else {
                successStatus.text = "That is incorrect. The correct answer was " + chords[0].name
                successStatus.isHidden = false
            }
            playMode = false
        }
    }
    
    // Determine whether the user has placed their choice within the bounding box of the fretboard
    func moveIsWithinFretboard(x: CGFloat, y: CGFloat) -> Bool {
        return (x >= 68) && (x <= 278) && (y >= 68) && (y <= 455)
    }
    
    // If play mode is over and the user taps on the screen, start the next round
    @IBAction func onTapScreen(_ sender: UITapGestureRecognizer) {
        if !playMode {
            resetGame()
            playRound()
        }
    }
    
}

