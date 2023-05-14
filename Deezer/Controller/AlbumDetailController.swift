//
//  AlbumDetailController.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit

private let cellIdentifier = "SongCell"

final class AlbumDetailController: UIViewController {
    
    //MARK: - Properties
    
    private let album: Album
    
    private var songs = [Song]() {
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
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchSongs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Player.shared.pause()
    }
    
    //MARK: - API
    
    private func fetchSongs() {
        DeezerService.fetchSongs(withAlbumId: album.id) { songs in
            self.songs = songs
        }
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = album.title
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
    
    private func refreshFavorites() {
        DeezerBrain.shared.loadFavorites()
        songCV.reloadData()
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension AlbumDetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        song.isFavorite = DeezerBrain.shared.checkIfFavorite(song: song)
        cell.viewModel = SongViewModel(song: song)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Player.shared.handlePlay(songs: songs, index: indexPath.row) { songEnd in
            self.refreshFavorites()
        }
        refreshFavorites()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension AlbumDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)
        return CGSize(width: cellWidth, height: 100)
    }
}

//MARK: - SongCellDelegate

extension AlbumDetailController: SongCellDelegate {
    func addFavorite(song: Song) {
        DeezerBrain.shared.addFavorite(song: song)
        song.isFavorite = true
    }
    
    func deleteFavorite(song: Song) {
        DeezerBrain.shared.deleteFavorite(song: song)
        song.isFavorite = false
    }
}
