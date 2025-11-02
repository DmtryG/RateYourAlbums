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
