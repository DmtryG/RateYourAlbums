//
//  LargeRatingBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftUI

struct LargeRatingBadgeView: View {
    let rating: Double
    var size: CGFloat = 120
    
    var body: some View {
        ZStack {
            Circle()
                .fill(getRatingColor(rating).opacity(0.3))
                .blur(radius: 8)
            Circle()
                .strokeBorder(getRatingColor(rating), lineWidth: size * 0.06)
            
            VStack (spacing: 4) {
                if (rating != 10.0) {
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                        .foregroundStyle(getRatingColor(rating))
                    Text ("/ 10")
                        .font(.system(size: size * 0.15, weight: .medium, design: .rounded))
                } else {
                    Text ("10")
                        .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                        .foregroundStyle(getRatingColor(rating))
                    Text ("/ 10")
                        .font(.system(size: size * 0.15, weight: .medium))
                        .opacity(0.7)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    LargeRatingBadgeView(rating: 10)
}
