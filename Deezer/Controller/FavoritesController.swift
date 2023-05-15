//
//  FavoritesController.swift
//  Deezer
//
//  Created by ibrahim uysal on 13.05.2023.
//

import UIKit

private let cellIdentifier = "SongCell"

final class FavoritesController: UICollectionViewController {
    
    //MARK: - Properties
    
    private var favorites = [Song]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let refresher = UIRefreshControl()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Player.shared.pause()
    }
    
    //MARK: - Selectors
    
    @objc private func refreshFavorites() {
        DeezerBrain.shared.loadFavorites()
        favorites = DeezerBrain.shared.favorites
        refresher.endRefreshing()
        Player.shared.pause()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = "Favorites"
        view.backgroundColor = .systemGroupedBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        refresher.addTarget(self, action: #selector(refreshFavorites), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension FavoritesController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SongCell
        let song = favorites[indexPath.row]
        cell.viewModel = SongViewModel(song: song)
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Player.shared.handlePlay(songs: favorites, index: indexPath.row) { songEnd in
            if songEnd { Player.shared.stopTimer() }
            self.collectionView.reloadData()
        }
        self.collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)
        return CGSize(width: cellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

//MARK: - SongCellDelegate

extension FavoritesController: SongCellDelegate {
    func addFavorite(song: Song) {
        DeezerBrain.shared.addFavorite(song: song)
        song.isFavorite = true
    }
    
    func deleteFavorite(song: Song) {
        DeezerBrain.shared.deleteFavorite(song: song)
        song.isFavorite = false
    }
}
