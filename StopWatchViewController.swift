//
//  StopWatchViewController.swift
//  StopwatchClone
//
//  Created by Bennett Mackenzie on 7/12/2022.
//

//  TODO: change button color on click
//  TODO: add table cell when lap button is pressed

import UIKit

class StopWatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var lapResetButton: UIButton!
    
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var fractionalLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    var laps = [String]()
    var timeString:String = String()
    
    var timer:Timer = Timer()
    var (minutes, seconds, fractions) = (0, 0, 0)
    var isTiming:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        if(!isTiming) {
            (minutes, seconds, fractions) = (0, 0, 0)
            minutesLabel.text = "00:"
            secondsLabel.text = "00"
            fractionalLabel.text = ".00"
            lapResetButton.setTitle("Lap", for: .normal)
            resetLaps()
        } else {
            newLap()
        }
        
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
        
        let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        timeString = "\(minutesString):\(secondsString).\(fractionString)"
        
        minutesLabel.text = "\(minutesString):"
        secondsLabel.text = "\(secondsString)"
        fractionalLabel.text = ".\(fractionString)"
        
    }
    
    func newLap() {
        let lap:String = "\(timeString)"
        laps.insert(lap, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func resetLaps() {
        laps.removeAll()
        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = "\(timeString)"
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
    }
    
}
