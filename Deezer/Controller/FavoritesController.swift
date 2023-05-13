//
//  FavoritesController.swift
//  Deezer
//
//  Created by ibrahim uysal on 13.05.2023.
//

import UIKit

private let cellIdentifier = "SongCell"

final class FavoritesController: UIViewController {
    
    //MARK: - Properties
    
    private var favorites = [Song]() {
        didSet {
            DispatchQueue.main.async {
                self.songCV.reloadData()
            }
        }
    }
    
    private var songCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DeezerBrain.shared.loadFavorites()
        favorites = DeezerBrain.shared.favorites
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = "Favorites"
        view.backgroundColor = .systemGroupedBackground
        
        songCV.delegate = self
        songCV.dataSource = self
        songCV.backgroundColor = .clear
        songCV.register(SongCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func layout() {
        view.addSubview(songCV)
        songCV.fillSuperview()
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension FavoritesController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SongCell
        let song = favorites[indexPath.row]
        cell.viewModel = SongViewModel(song: song)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = favorites[indexPath.row]
        if song.isPlaying {
            Player.shared.player?.pause()
            favorites[indexPath.row].isPlaying = false
        } else {
            Player.shared.playSound(withUrl: song.preview ?? "")
            for i in 0..<favorites.count { favorites[i].isPlaying = false }
            favorites[indexPath.row].isPlaying = true
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)
        return CGSize(width: cellWidth, height: 100)
    }
}

//MARK: - SongCellDelegate

extension FavoritesController: SongCellDelegate {
    func addFavorite(song: Song) {
//        DeezerBrain.shared.addFavorite(song: song)
    }
    
    func deleteFavorite(song: Song) {
//        DeezerBrain.shared.deleteFavorite(song: song)
    }
}
