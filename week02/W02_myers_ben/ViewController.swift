//
//  ViewController.swift
//  W02_myers_ben
//
//  Created by MYERS BENJAMIN D on 8/31/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelValue: UILabel!
    let OZ_ML_CONVERSION_FACTOR = 29.5735
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertOzToMl(oz: Double) -> Double {
        return OZ_ML_CONVERSION_FACTOR * oz
    }
    
    func convertMlToOz(ml: Double) -> Double {
        return ml/OZ_ML_CONVERSION_FACTOR
    }

    @IBAction func buttonConvertTapped(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case let endUnits where endUnits == "oz": // converts ml to fl oz
            let ml = Double(labelValue!.text!)
            let oz = convertMlToOz(ml: ml!)
            labelValue.text = String(oz)
        case let endUnits where endUnits == "ml": // converts fl oz to ml
            let oz = Double(labelValue!.text!)
            let ml = convertOzToMl(oz: oz!)
            labelValue.text = String(ml)
        default: // unreachable, hopefully
            labelValue.text = "ERROR"
        }
    }
    @IBAction func buttonClearTapped(_ sender: UIButton) {
        labelValue.text = "0"
    }
    
    @IBAction func buttonDigitTapped(_ sender: UIButton) {
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

