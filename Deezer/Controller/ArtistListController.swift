//
//  CategoryDetailController.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit

private let reuseIdentifier = "ArtistCell"

final class ArtistListController: UIViewController {
    
    //MARK: - Properties
    
    private let category: Category
    
    private var artists = [Artist]() {
        didSet {
            DispatchQueue.main.async {
                self.artistCV.reloadData()
            }
        }
    }
    
    private var artistCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    //MARK: - Lifecycle
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchArtists()
    }
    
    //MARK: - API
    
    private func fetchArtists() {
        DeezerService.fetchArtists(withId: category.id) { artists in
            self.artists = artists
        }
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = category.name
        view.backgroundColor = .systemGroupedBackground
        
        artistCV.delegate = self
        artistCV.dataSource = self
        artistCV.backgroundColor = .clear
        artistCV.register(ArtistCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func layout() {
        view.addSubview(artistCV)
        artistCV.fillSuperview()
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension ArtistListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        let artist = artists[indexPath.row]
        cell.viewModel = ArtistViewModel(artist: artist)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG::name=\(artists[indexPath.row].name)")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ArtistListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)/2
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
