//
//  Artist.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

// MARK: - ArtistResponse

struct ArtistResponse: Codable {
    let artists: [Artist]
    
    enum CodingKeys : String, CodingKey {
        case artists = "data"
    }
}

// MARK: - Artist

struct Artist: Codable {
    let id: Int
    let name: String?
    let picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let radio: Bool?
    let tracklist: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type
    }
}
