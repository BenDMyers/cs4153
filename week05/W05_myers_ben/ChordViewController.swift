//
//  ChordViewController.swift
//  W05_myers_ben
//
//  Created by MYERS BENJAMIN D on 9/21/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit

class ChordViewController: UIViewController {
    
    public var chord = (name: "", aFret: 0, eFret: 0, cFret: 0, gFret: 0)
    
    // x-coords of strings ([0] is a dummy)
    //let stringCoords = [-1, 299, 229, 155, 83]
    
    // y-coords of frets ([0] is a dummy)
    let fretCoords = [-1, 225, 305, 385, 465]
    
    @IBOutlet weak var aDot: UIImageView!
    @IBOutlet weak var eDot: UIImageView!
    @IBOutlet weak var cDot: UIImageView!
    @IBOutlet weak var gDot: UIImageView!
    
    @IBOutlet weak var chordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFretboard()
        chordLabel.text = chord.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureFretboard() {
        
        aDot.isHidden = true
        eDot.isHidden = true
        cDot.isHidden = true
        gDot.isHidden = true
        
        if chord.aFret > 0 {
            aDot.isHidden = false
            aDot.frame.origin.y = CGFloat(fretCoords[chord.aFret])
        }
        if chord.eFret > 0 {
            eDot.isHidden = false
            eDot.frame.origin.y = CGFloat(fretCoords[chord.eFret])
        }
        if chord.cFret > 0 {
            cDot.isHidden = false
            cDot.frame.origin.y = CGFloat(fretCoords[chord.cFret])
        }
        if chord.gFret > 0 {
            gDot.isHidden = false
            gDot.frame.origin.y = CGFloat(fretCoords[chord.gFret])
        }
    }
    
}


