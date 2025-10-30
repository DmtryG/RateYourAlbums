//
//  InfoBadge.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI

struct InfoBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack (spacing: 4) {
            Image (systemName: icon)
                .font(.caption2)
            Text (text)
                .font(.caption)
                .lineLimit(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color(.systemGray5))
        .clipShape(.capsule)
        .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    InfoBadge(icon: "music.note", text: "Hip Hop")
}
