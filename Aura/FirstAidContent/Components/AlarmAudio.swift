//
//  AlarmAudio.swift
//  Aura
//
//  Created by Hubert Daryanto on 26/10/20.
//

import Foundation
import AVFoundation

class AlarmAudio: ObservableObject
{
    var alarm: AVAudioPlayer?
    
    let path = Bundle.main.path(forResource: "ES_Police Siren Two - SFX Producer.mp3", ofType: nil)!
    
    func playaudio() -> AVAudioPlayer
    {
        let url = URL(fileURLWithPath: path)
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            alarm = try AVAudioPlayer(contentsOf: url)
            alarm?.numberOfLoops = -1
        }
        catch
        {
            
        }
        return alarm!
    }
    
}
