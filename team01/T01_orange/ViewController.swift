//
//  ViewController.swift
//  T01_orange
//
//  Created by Orange Team on 9/18/17.
//  Copyright © 2017 Brightest Orange. All rights reserved.
//


import UIKit

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension String
{
    /** Adds leading zero to beginning of number if necessary */
    func pad() -> String {
        guard self.characters.count < 2 else {return self}
        
        return "0" + self
    }
}

var Images: [String] = []
var coordinates: [(x: CGFloat, y: CGFloat)] = []
class ViewController: UIViewController {
    
    let TIMED_FREE_PLAY_MODE = 1
    let COUNTED_FREE_PLAY_MODE = 2
    let TIMED_MODE = 3
    let COUNTED_MODE = 4
    
    var possibleImages = [ "card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10"]
    
    var buttonArray : [UIButton] = []
    var backView: UIImageView!
    var frontView: UIImageView!
    var timer = Timer()
    var currentTime: Int = 0
    var moves : Int = 0
    var pairsFound: Int = 0
    //howManyPairs max is equal to possibleImages.count, min should be 2
    var activeButtonArray : [UIButton] = []
    var key = "mode1"
    var gameOver: Bool = false
    
    var gameMode = 2
    var howManyPairs = 6
    var timeLimit = 1 * 3600
    var moveLimit: Int = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var moveLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillImages()
        startTimer()
        drawButtons()
        //clearUserDefaults()
    }
    
    //fill Images with random images from possibleImages
    func fillImages(){
        let temp = possibleImages
        possibleImages.shuffle()
        for _ in 0...howManyPairs-1 {
            Images.append(possibleImages[0])
            Images.append(possibleImages[0])
            possibleImages.remove(at: 0)
        }
        Images.shuffle()
        possibleImages = temp
    }
    
    //draws the buttons
    //adds action to each button that calls buttonFlipOnTap
    func drawButtons(){
        let numberOfCards: Double = Double(howManyPairs * 2)
        let column = Int(floor(numberOfCards.squareRoot()))
        let row = Int(ceil(numberOfCards / Double(column)))
        let controllerHeight = UIScreen.main.bounds.height * 0.9
        let controllerWidth = UIScreen.main.bounds.width * 0.9
        let xBuffer = (UIScreen.main.bounds.height * 0.1) / CGFloat(column + 1)
        let yBuffer = (UIScreen.main.bounds.width * 0.1) / CGFloat(row + 1)
        let rectHeight = (controllerHeight - (UIScreen.main.bounds.height * 0.1)) / CGFloat(row)
        let rectWidth = (controllerWidth - (UIScreen.main.bounds.width * 0.1)) / CGFloat(column)
        var cardsToDraw = Int(numberOfCards)
        for j in 0...(row - 1){
            if cardsToDraw <= 0 {
                break;
            }
            for i in 0...(column-1){
                if cardsToDraw <= 0 {
                    break;
                }
                let x = (controllerWidth * 0.01 / 0.9) + xBuffer + CGFloat(i) * rectWidth + CGFloat(i) * xBuffer
                let y = (controllerHeight * 0.1 / 0.9) + yBuffer + CGFloat(j) * rectHeight + CGFloat(j) * yBuffer
                let rect = CGRect(x: Int(x), y: Int(y), width: Int(rectWidth), height: Int(rectHeight))
                let button = UIButton(frame: rect)
                button.titleLabel?.alpha=0
                button.titleLabel?.text = Images[0]
                Images.remove(at: 0)
                button.setBackgroundImage(UIImage.init(named: "cardBackground"), for: UIControlState.normal)
                button.addTarget(self, action: #selector(buttonFliponTap), for: UIControlEvents.touchUpInside)
                self.view.addSubview(button)
                buttonArray.append(button)
                cardsToDraw = cardsToDraw - 1
            }
        }
        key = "mode\(gameMode)"
        if gameMode == COUNTED_MODE {
            moveLimit = howManyPairs * 4
            moveLabel.text = "Moves: \(moveLimit)"
        }
    }
    
    //action associated to card buttons, checks if the cards are equal, handles how many cards are active
    //calls incrementMoves and checkCards
    @objc func buttonFliponTap(sender: UIButton){
        if !gameOver && activeButtonArray.count < 2{
            if (sender.backgroundImage(for: UIControlState.normal)?.isEqual(UIImage.init(named: "cardBackground")))!{
                    UIView.transition(with: sender, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {sender.setBackgroundImage(UIImage(named: (sender.titleLabel?.text)!), for: UIControlState.normal)}, completion: nil)
                    //incrementMoves()
                    activeButtonArray.append(sender)
                    checkCards()
                    incrementMoves()
            }
            else{
                UIView.transition(with: sender, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {sender.setBackgroundImage(UIImage(named: "cardBackground"), for: UIControlState.normal)}, completion: nil)
                activeButtonArray = activeButtonArray.filter{ $0 != sender}
            }
        }
    }
    
    //starts the scheduledTimer
    //calls changeTime
    func startTimer(){
        currentTime = 0
        if gameMode == TIMED_FREE_PLAY_MODE || gameMode == TIMED_MODE {
            timeLabel.alpha = 1
            moveLabel.alpha = 0
            timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(ViewController.changeTime), userInfo: nil, repeats: true)
        }
        else if gameMode == COUNTED_FREE_PLAY_MODE || gameMode == COUNTED_MODE {
            timeLabel.alpha = 0
            moveLabel.alpha = 1
        }
    }
    
    //changes time display depending on game mode, also checks if time limit is up
    @objc func changeTime(){
        if gameMode == TIMED_FREE_PLAY_MODE {
            currentTime += 1
            let currentMin = currentTime / 3600
            let currentSecond = (currentTime - (60 * currentMin)) / 60 % 60
            let currentMili = (currentTime - (60 * currentMin)) % 60
            timeLabel.text = "\(String(currentMin).pad()):\(String(currentSecond).pad()).\(String(currentMili).pad())"
        }
        else{
            currentTime += 1
            let currentMin = (timeLimit - currentTime) / 3600
            let currentSecond = ((timeLimit - currentTime) - (60 * currentMin)) / 60 % 60
            let currentMili = ((timeLimit - currentTime) - (60 * currentMin)) % 60
            timeLabel.text = "\(String(currentMin).pad()):\(String(currentSecond).pad()).\(String(currentMili).pad())"
            if currentTime >= timeLimit {
                timer.invalidate()
                lose()
                timeLabel.text = "00:00.00"
            }
        }
    }
    
    //increment moves, changes move label, and sets gameOver to true, and actives loser popUp
    func incrementMoves(){
        moves += 1
        if gameMode == COUNTED_MODE {
            moveLabel.text = "Moves: \(moveLimit - moves)"
            if moves >= moveLimit && pairsFound < howManyPairs {
                lose()
            }
        }
        else{
            moveLabel.text = "Moves: \(moves)"
        }
    }
    
    // checks if cards match and calls disablePairs on a delay
    func checkCards(){
        // two cards are selected
        if activeButtonArray.count >= 2{
            // two cards match, call disablePairs on a delay
            if (activeButtonArray[0].backgroundImage(for: UIControlState.normal)?.isEqual(activeButtonArray[1].backgroundImage(for: UIControlState.normal)))!{
                pairsFound += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {self.disablePairs()})
            }
            // two cards do not match, unflip on delay
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    UIView.transition(with: self.activeButtonArray[0], duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {self.activeButtonArray[0].setBackgroundImage(UIImage(named: "cardBackground"), for: UIControlState.normal)}, completion: nil)
                    UIView.transition(with: self.activeButtonArray[1], duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {self.activeButtonArray[1].setBackgroundImage(UIImage(named: "cardBackground"), for: UIControlState.normal)}, completion: nil)
                    self.activeButtonArray.removeAll()
                })
            }
        }
    }
    
    // deactivates matched cards and fades them to invisible.
    // clears activeButtonArray
    // calls score
    func disablePairs() {
        activeButtonArray[0].isUserInteractionEnabled = false
        activeButtonArray[1].isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.activeButtonArray[0].alpha = 0
            self.activeButtonArray[1].alpha = 0
        })
        activeButtonArray.removeAll()
        score()
    }
    
    let scoreArray = UserDefaults.standard
    // checks if all the pairs are found, if so it stores either the time or the moves
    // depending on the game mode
    // and reveals win popup
    func score(){
        if pairsFound >= howManyPairs{
            timer.invalidate()
            gameOver = true
            let winTime = currentTime;
            
            // mode1 : standard time counter
            // mode2 : standard move counter
            // mode3 : time limit
            // mode4 : move limit
            if gameMode == TIMED_FREE_PLAY_MODE || gameMode == TIMED_MODE {
                if let toGet = scoreArray.array(forKey: key){
                    var toAppend = toGet as! [Int]
                    var wasntInserted : Bool = true
                    for i in 0...toAppend.count-1{
                        let toCheck = toAppend[i]
                        if toCheck == winTime {
                            wasntInserted = false
                            break;
                        }
                        else if toCheck > winTime {
                            toAppend.insert(winTime, at: i)
                            wasntInserted = false
                            break
                        }
                    }
                    if wasntInserted{
                        toAppend.append(winTime)
                    }
                    scoreArray.set(toAppend, forKey: key)
                }
                else{
                    let toAppend = [winTime]
                    scoreArray.set(toAppend, forKey: key)
                }
                scoreArray.synchronize()
            }
            else if gameMode == COUNTED_FREE_PLAY_MODE || gameMode == COUNTED_MODE {
                if let toGet = scoreArray.array(forKey: key){
                    var toAppend = toGet as! [Int]
                    var wasntInserted : Bool = true
                    for i in 0...toAppend.count-1{
                        let toCheck = toAppend[i]
                        if toCheck == moves {
                            wasntInserted = false
                            break;
                        }
                        else if toCheck > moves {
                            toAppend.insert(moves, at: i)
                            wasntInserted = false
                            break
                        }
                    }
                    if wasntInserted{
                        toAppend.append(moves)
                    }
                    scoreArray.set(toAppend, forKey: key)
                }
                else{
                    let toAppend = [moves]
                    scoreArray.set(toAppend, forKey: key)
                }
                scoreArray.synchronize()
            }
            win()
        }
        
    }
    
    //clears saved time and move data, inactive at normal run
    func clearUserDefaults(){
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    //clears the screen, redraws cards, sets needed counts to zero, and sets gameOver to false
    func newGame(){
        for i in buttonArray{
            i.removeFromSuperview()
        }
        activeButtonArray.removeAll()
        moveLabel.text = "Moves: 0"
        startTimer()
        fillImages()
        drawButtons()
        moves = 0
        pairsFound = 0
        gameOver = false
    }
    
    //calls newGame
    @objc func restartGame(sender: UIButton){
        newGame()
    }
    
    // Return to homescreen
    func returnToHome() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    // Alert user they have won and ask to play again
    func win() {
        gameOver = true
        let winAlertController = UIAlertController(title: "Congratulations!", message: "You win! Play again?", preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "OK", style: .default) {(result : UIAlertAction) in self.newGame()}
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(result : UIAlertAction) in self.returnToHome()}
        winAlertController.addAction(playAgainAction)
        winAlertController.addAction(cancelAction)
        self.present(winAlertController, animated: true, completion: nil)
    }
    
    // Alerts user they have lost and ask to play again
    func lose() {
        gameOver = true
        let loseAlertController = UIAlertController(title: "Oh, no!", message: "You lost! Play again?", preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "OK", style: .default) {(result : UIAlertAction) in self.newGame()}
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(result : UIAlertAction) in self.returnToHome()}
        loseAlertController.addAction(playAgainAction)
        loseAlertController.addAction(cancelAction)
        self.present(loseAlertController, animated: true, completion: nil)
    }
}


