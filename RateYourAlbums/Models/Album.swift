//
//  Album.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 28.10.2025.
//

import Foundation
import SwiftData

@Model
final class Album {
    @Attribute(.unique) var id: String
    var title: String
    var artistName: String
    var artworkURL: String?
    var releaseDate: String?
    var genre: String?
    var trackCount: Int?
    var copyright: String?
    var collectionPrice: Double?
    var currency: String?
    var primaryGenreName: String?
    
    // user rating
    var rating: Double
    var dateAdded: Date
    
    // for iTunes API
    var collectionViewURL: String?
    var country: String?
    
    init(id: String,
         title: String,
         artistName: String,
         artworkURL: String? = nil,
         releaseDate: String? = nil,
         genre: String? = nil,
         trackCount: Int? = nil,
         copyright: String? = nil,
         collectionPrice: Double? = nil,
         currency: String? = nil,
         primaryGenreName: String? = nil,
         rating: Double = 5.0,
         dateAdded: Date = Date(),
         collectionViewURL: String? = nil,
         country: String? = nil
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.releaseDate = releaseDate
        self.genre = genre
        self.trackCount = trackCount
        self.copyright = copyright
        self.collectionPrice = collectionPrice
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.rating = rating
        self.dateAdded = dateAdded
        self.collectionViewURL = collectionViewURL
        self.country = country
    }
}
