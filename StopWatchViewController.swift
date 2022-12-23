//
//  StopWatchViewController.swift
//  StopwatchClone
//
//  Created by Bennett Mackenzie on 7/12/2022.
//

import UIKit

class StopWatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private var startStopButton: UIButton!
    @IBOutlet private var lapResetButton: UIButton!
    

    @IBOutlet private var timeLabel: UILabel!
    
    @IBOutlet private var tableView: UITableView!
    
    
    private var laps = [Float]()
    
    private var timer:Timer = Timer()
    private var elapsedTime:Float = 0.0
    private var isTiming:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            timeLabel.text = "00:00.00"
            lapResetButton.setTitle("Lap", for: .normal)
            resetLaps()
        } else {
            newLap()
        }
        
    }
    
    
    @objc func timerStarted() {
        elapsedTime += 1
        timeLabel.text = "\(convertMilliseconds(elapsedTime))"
    }
    
    func convertMilliseconds(_: Float) -> String {
        let time = NSDate(timeIntervalSince1970: Double(elapsedTime / 100))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "mm:ss.SS"
        return formatter.string(from: time as Date)
    }
    
    func newLap() {
        let lap:Float = elapsedTime
        laps.append(lap)
        print(laps)
        tableView.reloadData()
    }
    
    func resetLaps() {
        elapsedTime = 0.0
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
        
        cell.detailTextLabel?.text = "\(laps.reversed()[indexPath.row])"
        cell.detailTextLabel?.textColor = UIColor.white
        return cell
    }
    
}
