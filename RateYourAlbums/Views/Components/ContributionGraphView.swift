//
//  ContributionGraphView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 05.11.2025.
//

import SwiftUI

struct ContributionGraphView: View {
    let contributions: [[DayContribution]]
    let monthLabels: [(month: String, weekIndex: Int)]
    
    private let cellSize: CGFloat = 20
    private let cellSpacing: CGFloat = 5
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack (alignment: .top, spacing: 0) {
                ScrollView (.horizontal, showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 4) {
                        ZStack (alignment: .topLeading) {
                            ForEach (monthLabels, id: \.weekIndex) { label in
                                Text(label.month)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                                    .offset(x: CGFloat(label.weekIndex) * (cellSize + cellSpacing))
                            }
                        }
                        .frame(height: 20)
                        
                        HStack (spacing: cellSpacing) {
                            ForEach(Array(contributions.enumerated()), id: \.offset) { weekIndex, week in
                                VStack (spacing: cellSpacing) {
                                    ForEach(week) { day in
                                        ContributionCell(contribution: day, size: cellSize)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            HStack (spacing: 6) {
                Text ("Less")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                ForEach(0..<5, id: \.self) { level in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(colorForLevel(level))
                        .frame(width: cellSize, height: cellSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
                        )
                }
                
                Text ("More")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 6)
        }
    }
    
    private func colorForLevel(_ level: Int) -> Color {
        switch level {
        case 0: return Color.gray.opacity(0.1)
        case 1: return Color.red.opacity(0.3)
        case 2: return Color.red.opacity(0.5)
        case 3: return Color.red.opacity(0.7)
        case 4: return Color.red
        default: return Color.gray.opacity(0.1)
        }
    }
}

#Preview {
    let calendar = Calendar.current
    let today = Date()
    
    var weeks: [[DayContribution]] = []
    
    for weekOffset in 0..<52 {
        var week: [DayContribution] = []
        for dayOffset in 0..<7 {
            let date = calendar.date(byAdding: .day, value: -(52 * 7) + (weekOffset * 7) + dayOffset, to: today)!
            let count = Int.random(in: 0...7)
            week.append(DayContribution(date: date, count: count))
        }
        weeks.append(week)
    }
    
    let monthLabels = [
        ("Jan", 0),
        ("Feb", 4),
        ("Mar", 8),
        ("Apr", 13),
        ("May", 17),
        ("Jun", 22),
        ("Jul", 26),
        ("Aug", 30),
        ("Sep", 35),
        ("Oct", 39),
        ("Nov", 43),
        ("Dec", 48)
    ]
    
    return ContributionGraphView(contributions: weeks, monthLabels: monthLabels)
}
