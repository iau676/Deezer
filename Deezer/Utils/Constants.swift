//
//  Constants.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

enum Images {
    static let note      = UIImage(named: "ic_note")?
                            .imageResized(to: CGSize(width: 24, height: 24))
                            .withTintColor(.lightGray)
    static let noteFill  = UIImage(named: "ic_note_fill")?
                            .imageResized(to: CGSize(width: 24, height: 24))
                            .withTintColor(.darkGray)
    static let heart     = UIImage(named: "ic_heart")?
                            .imageResized(to: CGSize(width: 24, height: 24))
                            .withTintColor(.lightGray)
    static let heartFill = UIImage(named: "ic_heart_fill")?
                            .imageResized(to: CGSize(width: 24, height: 24))
                            .withTintColor(.darkGray)
}
