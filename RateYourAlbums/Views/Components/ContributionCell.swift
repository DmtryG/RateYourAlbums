//
//  ContributionCell.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 05.11.2025.
//

import SwiftUI

struct ContributionCell: View {
    let contribution: DayContribution
    let size: CGFloat
    
    @State private var showTooltip = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(colorForLevel(contribution.level))
            .frame(width: size, height: size)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
            )
            .onTapGesture {
                showTooltip.toggle()
            }
            .popover(isPresented: $showTooltip) {
                VStack(alignment: .leading, spacing: 4) {
                    Text (formatDate(contribution.date))
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\(contribution.count) album\(contribution.count == 1 ? "" : "s")")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding(5)
                .presentationCompactAdaptation(.popover)
            }
    }
    
    private func colorForLevel (_ level: Int) -> Color {
        switch level {
        case 0: return Color.gray.opacity(0.1)
        case 1: return Color.red.opacity(0.3)
        case 2: return Color.red.opacity(0.5)
        case 3: return Color.red.opacity(0.7)
        case 4: return Color.red
        default: return Color.gray.opacity(0.1)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
