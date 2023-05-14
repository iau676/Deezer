//
//  ViewController.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

final class HomeController: UIViewController {
    
    //MARK: - Properties
    
    private var categories = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.categoryCV.reloadData()
            }
        }
    }
    
    private var categoryCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchCategories()
    }
    
    //MARK: - API
    
    private func fetchCategories() {
        DeezerService.fetchCategories { categories in
            self.categories = categories
        }
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = "Musics"
        view.backgroundColor = .systemGroupedBackground
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        categoryCV.backgroundColor = .clear
        categoryCV.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func layout() {
        view.addSubview(categoryCV)
        categoryCV.fillSuperview()
    }
}

//MARK: - UICollectionViewDelegate/DataSource

extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        cell.viewModel = CategoryViewModel(category: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let controller = ArtistListController(category: category)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width-3*8)/2
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
