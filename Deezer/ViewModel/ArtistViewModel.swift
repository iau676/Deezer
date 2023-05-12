//
//  ArtistViewModel.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct ArtistViewModel {
    
    private let artist: Artist
    
    var artistName: String {
        return artist.name ?? "Artist"
    }

    var pictureMediumUrl: URL? {
        return URL(string: artist.pictureMedium ?? "")
    }
    
    init(artist: Artist) {
        self.artist = artist
    }
    
}
