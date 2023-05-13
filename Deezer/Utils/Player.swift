//
//  Player.swift
//  Deezer
//
//  Created by ibrahim uysal on 13.05.2023.
//

import UIKit
import AVFoundation

struct Player {
    
    static var shared = Player()
    
    var player: AVPlayer?
    
    mutating func playSound(withUrl url: String) {
        if let url = URL(string: url) {
            let playerItem:AVPlayerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
    }
}
