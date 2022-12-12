//
//  StopWatchViewController.swift
//  StopwatchClone
//
//  Created by Bennett Mackenzie on 7/12/2022.
//

//  TODO: change button color on click
//  TODO: add table cell when lap button is pressed

import UIKit

class StopWatchViewController: UIViewController {
    
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var lapResetButton: UIButton!
    
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var fractionalLabel: UILabel!
    
    var laps = [String]()
    var lapCount = 0
    
    var timer:Timer = Timer()
    var (minutes, seconds, fractions) = (0, 0, 0)
    var isTiming:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapResetButton.layer.cornerRadius = lapResetButton.frame.width/2
        startStopButton.layer.cornerRadius = startStopButton.frame.width/2
    }
    
    
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(!isTiming) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
            isTiming = true
            startStopButton.setTitle("Stop", for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
        } else {
            isTiming = false
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
            
        }
        
    }
    
    
    @IBAction func lapResetTapped(_ sender: Any) {
        (minutes, seconds, fractions) = (0, 0, 0)
        minutesLabel.text = "00:"
        secondsLabel.text = "00"
        fractionalLabel.text = ".00"
        lapResetButton.setTitle("Lap", for: .normal)
        newLap()
    }
    
    
    @objc func timerStarted() {
        fractions += 1
        
        if fractions > 99 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        minutesLabel.text = "\(minutesString):"
        secondsLabel.text = "\(secondsString)"
        fractionalLabel.text = ".\(fractions)"
    }
    
    func newLap() {
        lapCount += 1
        laps.append("Lap \(lapCount)")
        print(laps)
    }
}
