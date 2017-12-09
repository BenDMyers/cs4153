//
//  ViewController.swift
//  W07_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/3/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var BeatLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var bpcLabel: UILabel!
    @IBOutlet weak var bpcSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    
    var timer: Timer!
    var audio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bpmLabel.text = "Beats per minute: " + String(Int(bpmSlider.value))
        bpcLabel.text = "Beats per cycle: " + String(Int(bpcSlider.value))
        BeatLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Receives slider changes and stops metronome if necessary
    @IBAction func sliderChanged(_ sender: UISlider) {
        if timer != nil {
            timer.invalidate()
            startButton.setImage(#imageLiteral(resourceName: "button_start.png"), for: .normal)
            startButton.setTitle("Start", for: .normal)
        }
        
        BeatLabel.isHidden = true
        startButton.isHidden = false
        BeatLabel.text = "0"
        bpmLabel.text = "Beats per minute: " + String(Int(bpmSlider.value))
        bpcLabel.text = "Beats per cycle: " + String(Int(bpcSlider.value))
    }
    
    // Turn metronome on and off at the click of the start/stop button
    @IBAction func toggleMetronome(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            BeatLabel.text = "0"
            BeatLabel.isHidden = false
            sender.setImage(#imageLiteral(resourceName: "button_stop.png"), for: .normal)
            sender.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(
                timeInterval: TimeInterval(60.0/bpmSlider.value),
                target: self,
                selector: #selector(tick),
                userInfo: nil,
                repeats: true)
            timer.fire()
        }
        else {
            BeatLabel.isHidden = true
            sender.setImage(#imageLiteral(resourceName: "button_start.png"), for: .normal)
            sender.setTitle("Start", for: .normal)
            timer.invalidate()
        }
    }
    
    // Sent to timer, activated every tick of metronome
    @objc func tick(timer: Timer) {
        BeatLabel.text = String((Int(BeatLabel.text!)! % Int(bpcSlider.value)) + 1)
        playSound()
    }
    
    // Plays metronome ticking sound
    func playSound() {
        guard let url = Bundle.main.url(forResource: "metronome", withExtension: "mp3") else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            audio = try AVAudioPlayer(contentsOf: url)
            guard let audio = audio else {return}
            audio.prepareToPlay()
            audio.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

