//
//  CategoryDetailController.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit

private let reuseIdentifier = "ArtistCell"

final class ArtistListController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let category: Category
    
    private var artists = [Artist]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    //MARK: - Lifecycle
    
    init(category: Category) {
        self.category = category
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchArtists()
    }
    
    //MARK: - API
    
    private func fetchArtists() {
        DeezerService.fetchArtists(withId: category.id) { artists in
            self.artists = artists
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = category.name
        view.backgroundColor = .systemGroupedBackground
        
        collectionView.backgroundColor = .clear
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension ArtistListController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        let artist = artists[indexPath.row]
        cell.viewModel = ArtistViewModel(artist: artist)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        let controller = ArtistDetailController(artist: artist)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ArtistListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)/2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
