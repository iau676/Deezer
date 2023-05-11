//
//  ViewController.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    //MARK: - Properties
    
    private let label = UILabel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    //MARK: - Helpers
    
    private func style() {
        title = "Categories"
        view.backgroundColor = .darkGray
        
        label.text = "HomeController"
        label.numberOfLines = 0
    }
    
    private func layout() {
        view.addSubview(label)
        label.centerY(inView: view)
        label.centerX(inView: view)
    }
}

