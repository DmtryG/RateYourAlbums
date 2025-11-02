//
//  LibraryViewModel.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftData
import Foundation

enum SortOption: String, CaseIterable {
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

@Observable
class LibraryViewModel {
    var searchText = ""
    var selectedSortOption: SortOption = .dateAdded
    var albums: [Album] = []
    
    private var modelContext: ModelContext?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func fetchAlbums() {
        guard let modelContext = modelContext else {
            return
        }
        
        let descriptor = FetchDescriptor<Album>(
            sortBy: selectedSortOption.sortDescriptor
        )
        
        do {
            albums = try modelContext.fetch(descriptor)
        } catch {
            print ("Error fetching albums: \(error)")
        }
    }
    
    var filteredAlbums: [Album] {
        if searchText.isEmpty {
            return albums
        } else {
            return albums.filter { album in
                album.title.localizedCaseInsensitiveContains(searchText) ||
                album.artistName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var albumsByMonth: [(monthYear: String, albums: [Album])] {
        let filtered = filteredAlbums
        
        let groupedDictionary = Dictionary(grouping: filtered) { album -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            formatter.locale = Locale(identifier: "en_US")
            return formatter.string(from: album.dateAdded)
        }
            
        let sorted = groupedDictionary.sorted { first, second in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            formatter.locale = Locale(identifier: "en_US")
            
            guard let firstDate = formatter.date(from: first.key),
                  let secondDate = formatter.date(from: second.key) else {
                return false
            }
            
            return firstDate > secondDate
        }
        
        return sorted.map { (monthYear: $0.key, albums: $0.value)}
    }
    
    func deleteAlbum(_ album: Album) {
        guard let modelContext = modelContext else {
            return
        }
        modelContext.delete(album)
        try? modelContext.save()
        fetchAlbums()
    }
    
    func updateAlbumRating(_ album: Album, newRating: Double) {
        album.rating = newRating
        try? modelContext?.save()
        fetchAlbums()
    }
    
    func albumExists(id: String) -> Bool {
        guard let modelContext = modelContext else {
            return false
        }
        
        let descriptor = FetchDescriptor<Album>(
            predicate: #Predicate { album in
                album.id == id
            }
        )
        
        do {
            let albums = try modelContext.fetch(descriptor)
            return !albums.isEmpty
        } catch {
            return false
        }
    }
    
    func getAlbum(id: String) -> Album? {
        guard let modelContext = modelContext else {
            return nil
        }
        
        let descriptor = FetchDescriptor<Album>(
            predicate: #Predicate { album in
                album.id == id
            }
        )
        
        do {
            let albums = try modelContext.fetch(descriptor)
            return albums.first
        } catch {
            return nil
        }
    }
}
