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
    private var player: AVPlayer?
    private var timeR = Timer()
    
    mutating func handlePlay(songs: [Song], index: Int, completion: @escaping(Bool) -> Void) {
        timeR.invalidate()
        
        let song = songs[index]
        if song.isPlaying {
            player?.pause()
            songs[index].isPlaying = false
        } else {
            playSound(withUrl: song.preview ?? "")
            for i in 0..<songs.count { songs[i].isPlaying = false }
            songs[index].isPlaying = true
            
            timeR = Timer.scheduledTimer(withTimeInterval: 30, repeats: false, block: { _ in
                song.isPlaying = false
                completion(true)
            })
        }
    }
    
    mutating func playSound(withUrl url: String) {
        if let url = URL(string: url) {
            let playerItem:AVPlayerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
}
