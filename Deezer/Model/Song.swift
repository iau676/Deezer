//
//  Song.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

// MARK: - AlbumDetail

struct AlbumDetail: Codable {
    let id: Int
    let title: String?
    let upc: String?
    let link, share, cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let genreID: Int?
    let genres: Genres?
    let label: String?
    let nbTracks, duration, fans: Int?
    let releaseDate: String?
    let recordType: String?
    let available: Bool?
    let tracklist: String?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let contributors: [Contributor]
    let artist: Artist?
    let type: String?
    let songResponse: SongResponse

    enum CodingKeys: String, CodingKey {
        case id, title, upc, link, share, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case genreID = "genre_id"
        case genres, label
        case nbTracks = "nb_tracks"
        case duration, fans
        case releaseDate = "release_date"
        case recordType = "record_type"
        case available, tracklist
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case contributors, artist, type
        case songResponse = "tracks"
    }
}
// MARK: - Contributor

struct Contributor: Codable {
    let id: Int
    let name: String?
    let link, share, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let radio: Bool?
    let tracklist: String?
    let type: String?
    let role: String?

    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type, role
    }
}

// MARK: - Genres

struct Genres: Codable {
    let data: [Category]
}

// MARK: - SongResponse

struct SongResponse: Codable {
    let songs: [Song]
    
    enum CodingKeys : String, CodingKey {
        case songs = "data"
    }
}

// MARK: - Song

class Song: Codable {
    let id: Int
    let readable: Bool?
    let title, titleShort, titleVersion: String?
    let link: String?
    let duration: Int
    let rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let artist: Artist?
    let album: Album
    let type: String?
    
    var isPlaying: Bool = false
    var isFavorite: Bool = false
    var currentSecond: Int = 0

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, album, type
    }
    
    init(id: Int64, title: String?, duration: Int64, preview: String?, album: Album) {
        self.id = Int(id)
        self.readable = nil
        self.title = title
        self.titleShort = nil
        self.titleVersion = nil
        self.link = nil
        self.duration = Int(duration)
        self.rank = nil
        self.explicitLyrics = nil
        self.explicitContentLyrics = nil
        self.explicitContentCover = nil
        self.preview = preview
        self.md5Image = nil
        self.artist = nil
        self.album = album
        self.type = nil
        self.isFavorite = true
    }
}
