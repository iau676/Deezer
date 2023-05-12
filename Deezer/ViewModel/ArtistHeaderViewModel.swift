//
//  ArtistHeaderViewModel.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct ArtistHeaderViewModel {
    
    private let artist: Artist

    var pictureXl: URL? {
        return URL(string: artist.pictureXl)
    }
    
    init(artist: Artist) {
        self.artist = artist
    }
    
}
