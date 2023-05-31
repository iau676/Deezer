//
//  DeezerBrain.swift
//  Deezer
//
//  Created by ibrahim uysal on 13.05.2023.
//

import UIKit
import CoreData

struct DeezerBrain {
        
    static var shared = DeezerBrain()
    
    var favorites = [Song]()
    var favoriteSongs = [FavoriteSong]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    mutating func addFavorite(song: Song) {
        let newItem = FavoriteSong(context: self.context)
        newItem.id = Int64(song.id)
        newItem.albumId = Int64(song.album.id)
        newItem.duration = Int64(song.duration)
        newItem.title = song.title
        newItem.imageUrl = song.album.cover
        newItem.previewUrl = song.preview
        newItem.date = Date()
        saveContext()
    }
    
    func deleteFavorite(song: Song) {
        for i in 0..<favorites.count {
            if favorites[i].id == song.id {
                context.delete(favoriteSongs[i])
                saveContext()
                break
            }
        }
    }
    
    func checkIfFavorite(song: Song) -> Bool {
        for i in 0..<favorites.count {
            if favorites[i].id == song.id {
                return true
            }
        }
        return false
    }
    
    mutating func loadFavorites(with request: NSFetchRequest<FavoriteSong> = FavoriteSong.fetchRequest()){
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            favoriteSongs = try context.fetch(request)
            convertToSong(favoriteSongs: favoriteSongs)
        } catch {
           print("Error fetching data from context \(error)")
        }
    }
    
    mutating func convertToSong(favoriteSongs: [FavoriteSong]) {
        var favorites = [Song]()
        favoriteSongs.forEach { favoriteSong in
            let album = Album(id: Int(favoriteSong.albumId), cover: favoriteSong.imageUrl)
            let song = Song(id: favoriteSong.id, title: favoriteSong.title,
                            duration: favoriteSong.duration, preview: favoriteSong.previewUrl,
                            album: album)
            favorites.append(song)
        }
        self.favorites = favorites
    }
    
    private func saveContext() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
    
}
