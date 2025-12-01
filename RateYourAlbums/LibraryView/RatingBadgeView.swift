//
//  RatingBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct RatingBadgeView: View {
    var body: some View {
        Circle()
            .foregroundStyle(.purple.opacity(0.15))
            .frame(width: 64, height: 64)
            .overlay(
                Circle()
                    .stroke(.purple.opacity(0.65), lineWidth: 5)
            )
    }
}

#Preview {
    RatingBadgeView()
}
