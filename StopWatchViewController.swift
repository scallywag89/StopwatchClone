//
//  StopWatchViewController.swift
//  StopwatchClone
//
//  Created by Bennett Mackenzie on 7/12/2022.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var lapResetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var isTiming:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapResetButton.layer.cornerRadius = lapResetButton.frame.width/2
        startStopButton.layer.cornerRadius = startStopButton.frame.width/2
        // Do any additional setup after loading the view.
    }


}
