//
//  ArtistHeader.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit
import SDWebImage

final class ArtistHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    var viewModel: ArtistHeaderViewModel? {
        didSet { configure() }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.layer.borderColor = UIColor.lightGray.cgColor
        iv.layer.borderWidth = 1
        return iv
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.setDimensions(width: 200, height: 200)
        imageView.layer.cornerRadius = 200 / 2
        imageView.centerX(inView: self)
        imageView.centerY(inView: self)
        
        addSubview(lineView)
        lineView.setHeight(1)
        lineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                        right: rightAnchor, paddingBottom: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }

        imageView.sd_setImage(with: viewModel.pictureXl)
    }
}
