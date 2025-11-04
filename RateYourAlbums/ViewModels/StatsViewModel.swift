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
        let calendar = Calendar.current
        let today = Date()
        
        guard let startDate = calendar.date(byAdding: .weekOfYear, value: -52, to: today) else {
            return []
        }
        
        guard let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startDate)) else {
            return []
        }
        
        let albumsByDate = Dictionary(grouping: albums) { album -> String in
            let components = calendar.dateComponents([.year, .month, .day], from: album.dateAdded)
            guard let date = calendar.date(from: components) else {
                return ""
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
            return formatter.string(from: date)
        }
        
        var weeks: [[DayContribution]] = []
        var currentWeek: [DayContribution] = []
        var currentDate = weekStart
        
        for _ in 0..<(53 * 7) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
            let dateString = formatter.string(from: currentDate)
            
            let count = albumsByDate[dateString]?.count ?? 0
            let contribution = DayContribution(date: currentDate, count: count)
            currentWeek.append(contribution)
            
            if currentWeek.count == 7 {
                weeks.append(currentWeek)
                currentWeek = []
            }
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            
            if currentDate > today {
                break
            }
        }
        
        if !currentWeek.isEmpty {
            weeks.append(currentWeek)
        }
        
        return weeks
    }
    
    func getMonthLabels() -> [(month: String, weekIndex: Int)] {
        let calendar = Calendar.current
        let today = Date()
        
        guard let startDate = calendar.date(byAdding: .weekOfYear, value: -52, to: today) else {
            return []
        }
        
        guard let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startDate)) else {
            return []
        }
        
        var labels: [(String, Int)] = []
        var currentDate = weekStart
        var lastMonth = -1
        var weekIndex = 0
        
        for _ in 0..<53 {
            let month = calendar.component(.month, from: currentDate)
            
            if month != lastMonth {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM"
                let monthString = formatter.string(from: currentDate)
                labels.append((monthString, weekIndex))
                lastMonth = month
            }
            
            currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
            weekIndex += 1
            
            if currentDate > today {
                break
            }
        }
        
        return labels
    }
}
