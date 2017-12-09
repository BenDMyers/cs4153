//
//  scoreViewController.swift
//  T01_orange
//
//  Created by WOOD SAMUEL R on 9/25/17.
//  Copyright © 2017 Brightest Orange. All rights reserved.
//

import UIKit

class scoreViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setScores()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //sets score labels from UserDefaults
    //calls loadLabels four times
    func setScores(){
        let scoreArray = UserDefaults.standard
        for i in 1...4{
            let key: String = "mode\(i)"
            var toFillArray : [Int] = []
            if let toGet = scoreArray.array(forKey: key){
                var toAppend = toGet as! [Int]
                let limit: Int = min(toAppend.count-1, 9)
                for j in 0...limit{
                    toFillArray.append(toAppend[j])
                }
                loadLabels(array: toFillArray, mode: i)
                //toFillArray.reverse()
                scoreArray.set(toFillArray, forKey: key)
                scoreArray.synchronize()
            }
        }
    }
    
    //makes top ten labels for top ten scores for the needed game type
    func loadLabels(array: [Int], mode: Int){
        var x = 0
        var y = 0
        if mode == 1{
            x = 20
            y = 177
        }
        else if mode == 3{
            x = 275
            y = 177
        }
        else if mode == 2{
            x = 20
            y = 442
        }
        else if mode == 4{
            x = 275
            y = 442
        }
        for i in 0...9{
            let rect = CGRect(x: x, y: y + 22 * i, width: 100, height: 21)
            let label = UILabel(frame: rect)
            var toSet : String = "temp"
            if i <= array.count-1{
                if mode == 1 || mode == 3{
                    let currentTime = array[i];
                    let currentMin = currentTime / 3600
                    let currentSecond = (currentTime - (60 * currentMin)) / 60 % 60
                    let currentMili = (currentTime - (60 * currentMin)) % 60
                    toSet = "\(currentMin):\(currentSecond).\(currentMili)"
                }
                else{
                    toSet = "\(array[i])"
                }
            }
            else{
                toSet = ""
            }
            if mode == 3 || mode == 4{
                label.textAlignment = NSTextAlignment.right
            }
            else{
                label.textAlignment = NSTextAlignment.left
            }
            label.text = toSet
            self.view.addSubview(label)
        }
    }
    

}
