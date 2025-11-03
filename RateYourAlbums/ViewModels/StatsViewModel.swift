//
//  StatsViewModel.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 02.11.2025.
//

import Foundation
import SwiftData

struct DayContribution: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
    
    var level: Int {
        switch count {
        case 0: return 0
        case 1...2: return 1
        case 3...4: return 2
        case 5...6: return 3
        default: return 4
        }
    }
}

@Observable
class StatsViewModel {
    var albums: [Album] = []
    private var modelContext: ModelContext?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func fetchAlbums() {
        guard let modelContext else {
            return
        }
        
        let descriptor = FetchDescriptor<Album>(
            sortBy: [SortDescriptor(\Album.dateAdded, order: .reverse)]
        )
        
        do {
            albums = try modelContext.fetch(descriptor)
        } catch {
            print ("Error fetching albums: \(error)")
        }
    }
    
    var totalAlbumsRated: Int {
        return albums.count
    }
    
    var albumsRatedThisMonth: Int {
        let calendar = Calendar.current
        let now = Date()
        
        return albums.filter { album in
            calendar.isDate(album.dateAdded, equalTo: now, toGranularity: .month)
        }.count
    }
    
    var averageRating: Double {
        guard !albums.isEmpty else {
            return 0
        }
        
        let sum = albums.reduce(0.0) { $0 + $1.rating}
        return sum / Double(albums.count)
    }
    
    func getContributionData() -> [[DayContribution]] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        let today = Date()
        
        guard let startDate = calendar.date(byAdding: .weekOfYear, value: -52, to: today) else {
            return []
        }
    }
}
