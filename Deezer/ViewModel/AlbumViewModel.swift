//
//  AlbumViewModel.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct AlbumViewModel {
    
    private let album: Album
    
    var albumTitle: String {
        return album.title
    }
    
    var cover: URL? {
        return URL(string: album.cover)
    }
    
    var releaseDate: String {
        return dateToString(date: stringToDate(dateString: album.releaseDate))
    }
    
    init(album: Album) {
        self.album = album
    }
    
    private func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: dateString)
    }
    
    private func dateToString(date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date ?? Date())

    }
}
