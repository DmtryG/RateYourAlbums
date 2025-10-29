//
//  LibraryViewModel.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftData
import Foundation

enum sortOption: String, CaseIterable {
    case ratingDescending = "Rating (descending)"
    case ratingAscending = "Rating (ascending)"
    case dateAdded = "Date added"
    case artistName = "Artist name"
    
    var sortDescriptor: [SortDescriptor<Album>] {
        switch self {
        case .ratingDescending:
            return [SortDescriptor(\Album.rating, order: .reverse)]
        case .ratingAscending:
            return [SortDescriptor(\Album.rating, order: .forward)]
        case .dateAdded:
            return [SortDescriptor(\Album.dateAdded, order: .reverse)]
        case .artistName:
            return [SortDescriptor(\Album.artistName, order: .forward)]
        }
    }
}
