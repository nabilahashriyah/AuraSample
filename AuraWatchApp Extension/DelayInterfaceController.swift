//
//  DelayInterfaceController.swift
//  AuraWatchApp Extension
//
//  Created by Alldo Kurniawan on 12/11/20.
//

import WatchKit
import Foundation


class DelayInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var timerCounter: WKInterfaceTimer!
    
    @IBAction func cancelButton() {
        pop()
    }
    
    var myTimer : Timer?
    var isPaused = false
    var elapsedTime : TimeInterval = 0.0
    var startTime = NSDate()
    var duration : TimeInterval = 10.0
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        myTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: (#selector(self.timerDone)), userInfo: nil, repeats: false)
        timerCounter.setDate(NSDate(timeIntervalSinceNow: duration ) as Date)
        timerCounter.start()
        
        // Configure interface objects here.
    }
    
    override func willActivate(){
        super.willActivate()
        
        
    }
    
    @objc func timerDone(){
        print("Done")
        pushController(withName: "MainScreen", context: "")
    }
    
}
