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
    
    private let refresher = UIRefreshControl()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
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
    
    private func style() {
        title = "Favorites"
        view.backgroundColor = .systemGroupedBackground
        
        songCV.delegate = self
        songCV.dataSource = self
        songCV.backgroundColor = .clear
        songCV.register(SongCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        refresher.addTarget(self, action: #selector(refreshFavorites), for: .valueChanged)
        songCV.refreshControl = refresher
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
        Player.shared.handlePlay(songs: favorites, index: indexPath.row) { songEnd in
            if songEnd { Player.shared.stopTimer() }
            self.songCV.reloadData()
        }
        self.songCV.reloadData()
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
        DeezerBrain.shared.addFavorite(song: song)
        song.isFavorite = true
    }
    
    func deleteFavorite(song: Song) {
        DeezerBrain.shared.deleteFavorite(song: song)
        song.isFavorite = false
    }
}
