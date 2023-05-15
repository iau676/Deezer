//
//  DeezerService.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct DeezerService {
    
    static func fetchData(urlStr: String, completion: @escaping(Data) -> Void) {
        if let url = URL(string: urlStr) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    if let data = data {
                        completion(data)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    static func fetchCategories(completion: @escaping([Category]) -> Void) {
        fetchData(urlStr: "https://api.deezer.com/genre") { data in
            let categoryResponse = try! JSONDecoder().decode(CategoryResponse.self, from: data)
            completion(categoryResponse.categories)
        }
    }
    
    static func fetchArtists(withId id: Int, completion: @escaping([Artist]) -> Void) {
        fetchData(urlStr: "https://api.deezer.com/genre/\(id)/artists") { data in
            let artistResponse = try! JSONDecoder().decode(ArtistResponse.self, from: data)
            completion(artistResponse.artists)
        }
    }
    
    static func fetchAlbums(withArtistId id: Int, completion: @escaping([Album]) -> Void) {
        fetchData(urlStr: "https://api.deezer.com/artist/\(id)/albums") { data in
            let albumResponse = try! JSONDecoder().decode(AlbumResponse.self, from: data)
            completion(albumResponse.albums)
        }
    }
    
    static func fetchSongs(withAlbumId id: Int, completion: @escaping([Song]) -> Void) {
        fetchData(urlStr: "https://api.deezer.com/album/\(id)") { data in
            let albumDetail = try! JSONDecoder().decode(AlbumDetail.self, from: data)
            let songs = albumDetail.songResponse.songs
            completion(songs)
        }
    }
}
