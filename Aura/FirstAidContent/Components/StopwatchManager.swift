//
//  StopwatchManager.swift
//  Aura
//
//  Created by Hubert Daryanto on 06/10/20.
//

import Foundation
import SwiftUI
import AVFoundation

class StopwatchManager : ObservableObject {
    @Published var secondsElapsed = 0
    @Published var timerHeightSize:CGFloat = 114
    @Published var stepsViewHeightSize:CGFloat = UIScreen.main.bounds.size.height - 262
    @Published var flashlightOn: Bool = false
    @State var camera = AVCaptureDevice.default( .builtInWideAngleCamera, for: .video, position: .back)
    @Published var isHelped: Bool = false
    var timer = Timer()
    
    func start()
    {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        {
            timer in self.secondsElapsed += 1
            if self.secondsElapsed >= 300 {
                self.timerHeightSize = 150
                self.stepsViewHeightSize = UIScreen.main.bounds.size.height - 298
                if self.secondsElapsed == 300 {
                    DispatchQueue.main.async {
                        let recordIDs = NotificationRecord.instance.recordIDs
                        NotificationRecord.instance.updateNotification(generatedRecordID: recordIDs, contentType: .fivemin)
                    }
                }
            }
            if self.secondsElapsed % 2 == 0
            {
                self.flashlightOn = true
            }
            else
            {
                self.flashlightOn = false
            }
            if self.isHelped == false
            {
                self.blinkingFlashlight()
            }
            
        }
    }
    
    func secondsToMintesAndSeconds(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        
        return "\(minuteStamp) : \(secondStamp)"
    }
    
    func blinkingFlashlight()
    {
        try? camera?.lockForConfiguration()
        camera?.torchMode = self.flashlightOn ? .on : .off
        camera?.unlockForConfiguration()
    }
    
    func turnOffFlashlight()
    {
        try? camera?.lockForConfiguration()
        camera?.torchMode = .off
        camera?.unlockForConfiguration()
        
        DispatchQueue.main.async {
            let recordIDs = NotificationRecord.instance.recordIDs
            print(recordIDs)
            NotificationRecord.instance.updateNotification(generatedRecordID: recordIDs, contentType: .helped)
        }
    }
}
