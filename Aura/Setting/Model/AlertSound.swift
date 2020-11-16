//
//  AlertSound.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 06/11/20.
//

import Foundation
import AVFoundation

class AudioSound:ObservableObject{
    
    public var player: AVPlayer?
    
    /// To play music
    /// - Parameter audio: string audio file name to play
    func play(audio: String){
        let playerItem = AVPlayerItem(url: URL(string: audio)!)
              player = AVPlayer(playerItem: playerItem)
        player!.play()
    }
}
