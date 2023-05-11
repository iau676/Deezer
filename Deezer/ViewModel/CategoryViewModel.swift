//
//  CategoryViewModel.swift
//  Deezer
//
//  Created by ibrahim uysal on 12.05.2023.
//

import Foundation

struct CategoryViewModel {
    
    private let category: Category
    
    var categoryName: String {
        return category.name
    }
    
    init(category: Category) {
        self.category = category
    }
    
}
