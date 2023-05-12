//
//  DeezerService.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct DeezerService {
    
    static func fetchCategories(completion: @escaping([Category]) -> Void) {
        if let url = URL(string: "https://api.deezer.com/genre") {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    if let data = data {
                        let categoryResponse = try! JSONDecoder().decode(CategoryResponse.self, from: data)
                        completion(categoryResponse.categories)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    static func fetchArtists(withId id: Int, completion: @escaping([Artist]) -> Void) {
        if let url = URL(string: "https://api.deezer.com/genre/\(id)/artists") {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    if let data = data {
                        let artistResponse = try! JSONDecoder().decode(ArtistResponse.self, from: data)
                        completion(artistResponse.artists)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    static func fetchAlbums(withArtistId id: Int, completion: @escaping([Album]) -> Void) {
        if let url = URL(string: "https://api.deezer.com/artist/\(id)/albums") {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    if let data = data {
                        let albumResponse = try! JSONDecoder().decode(AlbumResponse.self, from: data)
                        completion(albumResponse.albums)
                    }
                }
            })
            dataTask.resume()
        }
    }
}
