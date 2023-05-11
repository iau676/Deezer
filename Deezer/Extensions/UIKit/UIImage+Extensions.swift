//
//  UIImage+Extensions.swift
//  Deezer
//
//  Created by ibrahim uysal on 11.05.2023.
//

import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

