//
//  RatingEditorView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.11.2025.
//

import SwiftUI

struct RatingEditorView: View {
    @Binding var rating: Double
    var maxRating: Int = 10
    
    var body: some View {
        VStack (spacing: 24) {
            LargeRatingBadgeView(rating: rating, size: 180)
            
            VStack (spacing: 1) {
                HStack {
                    Text ("1")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text ("10")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Slider(value: $rating, in: 1.0...Double(maxRating), step: 0.1)
                    .tint(getRatingColor(rating))
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    @Previewable @State var rating = 7.5
    RatingEditorView(rating: $rating)
}
