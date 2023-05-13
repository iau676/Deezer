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
    var favorites = [FavoriteSong]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    mutating func addFavorite(song: Song) {
        let newItem = FavoriteSong(context: self.context)
        newItem.id = Int64(song.id)
        newItem.albumId = Int64(song.album.id)
        newItem.artistId = Int64(song.artist.id)
        newItem.duration = Int64(song.duration)
        newItem.imageUrl = song.album.cover
        newItem.previewUrl = song.preview
        newItem.date = Date()
        self.favorites.append(newItem)
        saveContext()
    }
    
    func delete(favoriteSong: FavoriteSong) {
        context.delete(favoriteSong)
        saveContext()
    }
    
    mutating func loadFavorites(with request: NSFetchRequest<FavoriteSong> = FavoriteSong.fetchRequest()){
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            favorites = try context.fetch(request)
        } catch {
           print("Error fetching data from context \(error)")
        }
    }
    
    private func saveContext() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
    
}
