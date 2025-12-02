//
//  RatingBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

func getRatingColor (_ rating: Double) -> Color {
    switch rating {
    case 0..<4.0:
        return .red
    case 4.0..<7.0:
        return .orange
    case 7.0..<9.0:
        return .green
    case 9.0...10:
        return .purple.opacity(0.75)
    default:
        return .gray
    }
}

struct RatingBadgeView: View {
    let rating: Double
    var size: CGFloat
    var fontSize: CGFloat?
    var showOutOfTen = false
    
    private var displayFontSize: CGFloat {
        fontSize ?? size * 0.4
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(getRatingColor(rating).opacity(0.4))
                .blur(radius: 8)
            Circle()
                .stroke(getRatingColor(rating), lineWidth: size * 0.07)
            
            Text (String(rating))
                .font(.system(size: size * 0.4))
                .foregroundStyle(getRatingColor(rating))
                .fontWeight(.bold)
                .fontDesign(.rounded)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    RatingBadgeView(rating: 9.0, size: 250)
}
