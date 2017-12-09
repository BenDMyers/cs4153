//
//  ViewController.swift
//  W06_myers_ben
//
//  Created by MYERS BENJAMIN D on 9/28/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelValue: UILabel!
    let OZ_ML_CONVERSION_FACTOR = 29.5735
    let OZ = 1
    let ML = 2
    var units = 1
    var recentlyCalculated = false
    
    @IBOutlet weak var ozButton: UIButton!
    @IBOutlet weak var mlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ozButton.setTitleColor(UIColor.orange, for: .normal)
        ozButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Given a measure in fluid ounces, return the milliliter conversion
    func convertOzToMl(oz: Double) -> Double {
        return OZ_ML_CONVERSION_FACTOR * oz
    }
    
    // Given a measure in milliliters, return the fluid ounce conversion
    func convertMlToOz(ml: Double) -> Double {
        return ml/OZ_ML_CONVERSION_FACTOR
    }
    
    // One of the two unit conversion buttons has been pressed
    @IBAction func buttonConvertTapped(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case let endUnits where endUnits == "oz": // converts ml to fl oz
            if units != OZ {
                let ml = Double(labelValue!.text!)
                let oz = convertMlToOz(ml: ml!)
                labelValue.text = String(oz)
                units = OZ
                ozButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                ozButton.setTitleColor(UIColor.orange, for: .normal)
                mlButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                mlButton.setTitleColor(UIColor.black, for: .normal)
                recentlyCalculated = true
            }
        case let endUnits where endUnits == "ml": // converts fl oz to ml
            if units != ML {
                let oz = Double(labelValue!.text!)
                let ml = convertOzToMl(oz: oz!)
                labelValue.text = String(ml)
                units = ML
                ozButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                ozButton.setTitleColor(UIColor.black, for: .normal)
                mlButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                mlButton.setTitleColor(UIColor.orange, for: .normal)
                recentlyCalculated = true
            }
        default: // unreachable, hopefully
            labelValue.text = "ERROR"
        }
    }
    @IBAction func buttonClearTapped(_ sender: UIButton) {
        labelValue.text = "0"
    }
    
    @IBAction func buttonDigitTapped(_ sender: UIButton) {
        if recentlyCalculated {
            recentlyCalculated = false
            labelValue.text = "0"
        }
        switch sender.titleLabel?.text {
        case let digit where digit == "0":
            // Add a 0 unless the number is already cleared
            if labelValue.text != "0" {
                labelValue.text = labelValue.text! + "0"
            }
        case let digit where digit == ".":
            // At most one decimal point is allowed
            if labelValue.text?.range(of: ".") == nil {
                labelValue.text = labelValue!.text! + "."
            }
        default:
            if labelValue.text == "0" { // No leading zeroes
                labelValue!.text! = sender.titleLabel!.text!
            } else {
                labelValue!.text! += sender.titleLabel!.text!
            }
        }
    }
    
}

