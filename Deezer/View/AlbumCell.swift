//
//  AlbumCell.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit
import SDWebImage

final class AlbumCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: AlbumViewModel? {
        didSet {
            configure()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.text = "Album"
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "12 May 2023"
        return label
    }()
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemBackground
        iv.layer.cornerRadius = 16
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
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
        imageView.setDimensions(width: 100, height: 100)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor)
        
        addSubview(borderView)
        borderView.fillSuperview()
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel])
        textStack.axis = .vertical
        textStack.spacing = 8
        
        addSubview(textStack)
        textStack.centerY(inView: self)
        textStack.anchor(left: imageView.rightAnchor, right: rightAnchor,
                         paddingLeft: 16, paddingRight: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.albumTitle
        releaseDateLabel.text = viewModel.releaseDate
        imageView.sd_setImage(with: viewModel.cover)
    }
}
