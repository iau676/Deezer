//
//  SongCell.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import UIKit
import SDWebImage

protocol SongCellDelegate: AnyObject {
    func addFavorite(song: Song)
    func deleteFavorite(song: Song)
}

final class SongCell: UICollectionViewCell {
    
    //MARK: - Properties
        
    var viewModel: SongViewModel? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: SongCellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.text = "Song"
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "2:34\""
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(Images.heart, for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemBackground
        iv.layer.cornerRadius = 8
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return iv
    }()
    
    private let borderView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
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
        
        addSubview(favoriteButton)
        favoriteButton.setDimensions(width: 32, height: 32)
        favoriteButton.anchor(top: topAnchor, right: rightAnchor,
                          paddingTop: 16, paddingRight: 16)
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, durationLabel])
        textStack.axis = .vertical
        textStack.spacing = 8
        
        addSubview(textStack)
        textStack.centerY(inView: self)
        textStack.anchor(left: imageView.rightAnchor, right: favoriteButton.leftAnchor,
                         paddingLeft: 16, paddingRight: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc private func favoriteButtonPressed() {
        guard let viewModel = viewModel else { return }
        let song = viewModel.songSelf
        
        if song.isFavorite {
            delegate?.deleteFavorite(song: song)
            favoriteButton.setImage(Images.heart, for: .normal)
        } else {
            delegate?.addFavorite(song: song)
            favoriteButton.setImage(Images.heartFill, for: .normal)
        }
        
        favoriteButton.bounce()
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        durationLabel.text = viewModel.durationStr
        imageView.sd_setImage(with: viewModel.albumCover)
        favoriteButton.setImage(viewModel.favoriteImage, for: .normal)
    }
}
