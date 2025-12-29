//
//  Album.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 02.12.2025.
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
    var primaryGenreName: String?
    
    var rating: Double
    var dateAdded: Date
    
    var collectionViewURL: String?
    var country: String?
    
    init(id: String,
         title: String,
         artistName: String,
         artworkURL: String? = nil,
         releaseDate: String? = nil,
         genre: String? = nil,
         trackCount: Int? = nil,
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
        self.primaryGenreName = primaryGenreName
        self.rating = rating
        self.dateAdded = dateAdded
        self.collectionViewURL = collectionViewURL
        self.country = country
    }
}

struct AlbumDTO: Codable, Identifiable {
    let collectionId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl100: String?
    let artworkUrl60: String?
    let releaseDate: String?
    let primaryGenreName: String?
    let trackCount: Int?
    let collectionViewUrl: String?
    
    var id: String {
        String(collectionId)
    }
}
