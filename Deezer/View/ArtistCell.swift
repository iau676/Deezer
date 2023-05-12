//
//  ArtistCell.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit
import SDWebImage

final class ArtistCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: ArtistViewModel? {
        didSet {
            configure()
        }
    }
    
    private let label: UILabel = {
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
        
        addSubview(label)
        label.centerX(inView: self)
        label.anchor(bottom: bottomAnchor, paddingBottom: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        label.text = viewModel.artistName
        imageView.sd_setImage(with: viewModel.pictureMediumUrl)
    }
}
