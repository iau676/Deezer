//
//  ArtistDetailController.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit

private let reuseIdentifier = "AlbumCell"

final class ArtistDetailController: UIViewController {
    
    //MARK: - Properties
    
    private let artist: Artist
    
    private var albums = [Album]() {
        didSet {
            DispatchQueue.main.async {
                self.albumCV.reloadData()
            }
        }
    }
    
    private var albumCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    //MARK: - Lifecycle
    
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchAlbums()
    }
    
    //MARK: - API
    
    private func fetchAlbums() {
        DeezerService.fetchAlbums(withArtistId: artist.id) { albums in
            self.albums = albums
        }
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = artist.name
        view.backgroundColor = .systemGroupedBackground
        
        albumCV.delegate = self
        albumCV.dataSource = self
        albumCV.backgroundColor = .clear
        albumCV.register(AlbumCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func layout() {
        view.addSubview(albumCV)
        albumCV.fillSuperview()
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension ArtistDetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        cell.viewModel = AlbumViewModel(album: album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG::title=\(albums[indexPath.row].title)")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ArtistDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)
        return CGSize(width: cellWidth, height: 100)
    }
}
