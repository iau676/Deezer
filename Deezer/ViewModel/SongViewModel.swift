//
//  SongViewModel.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct SongViewModel {
    
    private let song: Song
    
    var songSelf: Song {
        return song
    }
    
    var title: String {
        return song.title ?? "Song"
    }
    
    var durationStr: String {
        return getDurationString(song.duration)
    }
    
    var albumCover: URL? {
        return URL(string: song.album.cover ?? "")
    }
    
    init(song: Song) {
        self.song = song
    }
    
    private func getDurationString(_ second: Int) -> String {
        let hour = second / 3600
        let min = (second - (hour*3600)) / 60
        let sec = second - ((hour*3600)+(min*60))
        
        let hourStr = "\(hour):"
        let minStr = "\(min):"
        let secStr = sec < 10 ? "0\(sec)\"" : "\(sec)\""
        
        return "\(hour > 0 ? hourStr : "")\(min > 0 ? minStr : "")\(sec > 0 ? secStr : "")"
    }
}
