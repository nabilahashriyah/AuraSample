//
//  MainInterfaceController.swift
//  AuraWatchApp Extension
//
//  Created by Alldo Kurniawan on 12/11/20.
//

import WatchKit
import Foundation
import AVKit
import AVFoundation

class MainInterfaceController: WKInterfaceController {
    
    var player: AVPlayer!
    
    @IBOutlet weak var descEpilepsy: WKInterfaceLabel!
    
    @IBAction func doneButton() {
        popToRootController()
    }
    @IBAction func tapRecognizer(_ sender: Any) {
        player.pause()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        descEpilepsy.setText("My Name is Jonathan and I’m having a seizure.\n\nPlease help me, by scanning the barcode below and following the First Aid steps")
        
        let filePath = Bundle.main.path(forResource: "ES_Police Siren Two - SFX Producer", ofType: "mp3")!
        let fileUrl = NSURL.fileURL(withPath: filePath)
        let asset = AVAsset(url: fileUrl)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        player.isMuted = false
        player.volume = 1.0
        player.play()
    }

}
