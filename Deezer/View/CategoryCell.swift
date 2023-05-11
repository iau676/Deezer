//
//  CategoryCell.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Category"
        return label
    }()
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemBackground
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    private let borderView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(borderView)
        borderView.fillSuperview()
        
        addSubview(categoryLabel)
        categoryLabel.centerX(inView: self)
        categoryLabel.anchor(bottom: bottomAnchor, paddingBottom: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
