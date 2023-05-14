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
        var timerCounter = 0
        
        let song = songs[index]
        if song.isPlaying {
            player?.pause()
            songs[index].isPlaying = false
        } else {
            playSound(withUrl: song.preview ?? "")
            songs.forEach { song in song.isPlaying = false }
            song.isPlaying = true
            song.currentSecond = 0
            
            timeR = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                timerCounter += 1
                song.currentSecond = timerCounter
                
                if timerCounter == 30 {
                    song.isPlaying = false
                    completion(true)
                } else {
                    completion(false)
                }
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
    
    func stopTimer() {
        timeR.invalidate()
    }
}
