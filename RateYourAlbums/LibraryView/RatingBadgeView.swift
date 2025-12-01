//
//  RatingBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct RatingBadgeView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.purple.opacity(0.15))
                .frame(width: 64, height: 64)
                .overlay(
                    Circle()
                        .stroke(.purple.opacity(0.6), lineWidth: 5)
                )
            
            Text ("8.9")
                .font(.title)
                .foregroundStyle(.purple.opacity(0.6))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    RatingBadgeView()
}
