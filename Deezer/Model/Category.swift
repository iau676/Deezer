//
//  Category.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

// MARK: - Category

struct CategoryResponse: Codable {
    let categories: [Category]
    
    enum CodingKeys : String, CodingKey {
        case categories = "data"
    }
}

// MARK: - Data

struct Category: Codable {
    let id: Int
    let name: String?
    let picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case type
    }
}
