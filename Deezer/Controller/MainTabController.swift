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
        self.delegate = self
        
        let home = templateNavigationController(image: Images.note,
                                                selectedImage: Images.noteFill,
                                                rootViewController: HomeController())
        
        let likes = templateNavigationController(image: Images.heart,
                                                 selectedImage: Images.heartFill,
                                                 rootViewController: HomeController())
        viewControllers = [home, likes]
    }
    
    private func templateNavigationController(image: UIImage?,
                                              selectedImage: UIImage?,
                                              rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        if let image = image?.imageResized(to: CGSize(width: 24, height: 24)),
            let selectedImage = selectedImage?.imageResized(to: CGSize(width: 24, height: 24)) {
            nav.tabBarItem.image = image
            nav.tabBarItem.selectedImage = selectedImage
            nav.navigationBar.tintColor = .blue
        }
        return nav
    }
}

//MARK: - UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController) {
            print("DEBUG::index=\(index)")
        }
        return true
    }
}

