//
//  MainTabController.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

final class MainTabController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    private func configureViewControllers() {
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        let home = templateNavigationController(image: Images.note,
                                                selectedImage: Images.noteFill,
                                                rootViewController: CategoryController(collectionViewLayout: layout))
        
        let favorites = templateNavigationController(image: Images.heart,
                                                     selectedImage: Images.heartFill,
                                                     rootViewController: FavoritesController(collectionViewLayout: layout))
        viewControllers = [home, favorites]
        
        tabBar.items?[0].title = "Musics"
        tabBar.items?[1].title = "Favorites"
    }
    
    private func templateNavigationController(image: UIImage?,
                                              selectedImage: UIImage?,
                                              rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        if let image = image,
            let selectedImage = selectedImage {
            nav.tabBarItem.image = image
            nav.tabBarItem.selectedImage = selectedImage
            nav.navigationBar.tintColor = .blue
        }
        return nav
    }
}
