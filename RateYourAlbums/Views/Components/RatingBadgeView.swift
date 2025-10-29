//
//  RatingBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftUI

extension View {
    func ratingColor (for rating: Double) -> Color {
        switch rating {
        case 0..<4.0:
            return .red
        case 4.0..<7.0:
            return .orange
        case 7.0..<10.0:
            return .green
        default:
            return .gray
        }
    }
}

func getRatingColor(_ rating: Double) -> Color {
    switch rating {
    case 0..<4.0:
        return .red
    case 4.0..<7.0:
        return .orange
    case 7.0...10.0:
        return .green
    default:
        return .gray
    }
}

struct RatingBadgeView: View {
    let rating: Double
    var size: CGFloat = 50
    var fontSize: CGFloat?
    var showOutOfTen: Bool = false
    
    private var displayFontSize: CGFloat {
        fontSize ?? size * 0.4
    }
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(getRatingColor(rating), lineWidth: size * 0.08)
                .background (
                    Circle()
                        .fill(getRatingColor(rating).opacity(0.15))
                )
            
            VStack (spacing: 0) {
                if rating != 10 {
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: displayFontSize, weight: .bold, design: .rounded))
                        .foregroundStyle(getRatingColor(rating))
                        .minimumScaleFactor(0.5)
                } else {
                    Text ("10")
                        .font(.system(size: displayFontSize, weight: .bold, design: .rounded))
                        .foregroundStyle(getRatingColor(rating))
                        .minimumScaleFactor(0.5)
                }
                
                if showOutOfTen {
                    Text("/10")
                        .font(.system(size: displayFontSize * 0.35, weight: .medium))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    RatingBadgeView(rating: 10.0, size: 60)
}
