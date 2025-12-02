//
//  InfoBadgeView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 02.12.2025.
//

import SwiftUI

struct InfoBadgeView: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            HStack (spacing: 4) {
                Image (systemName: icon)
                    .font(.caption2)
                    .fontDesign(.rounded)
                    .foregroundStyle(.title.opacity(0.8))
                    .fontWeight(.semibold)
                Text (text)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .foregroundStyle(.title.opacity(0.8))
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background (
                LinearGradient(colors: [Color.gradientColor1, Color.gradientColor2], startPoint: .top, endPoint: .bottom)
            )
            .clipShape(.capsule)
            .overlay (
                Capsule()
                    .stroke(Color.border, lineWidth: 1)
            )
            .fixedSize(horizontal: true, vertical: false)
        }
    }
}

#Preview {
    InfoBadgeView(icon: "guitars.fill", text: "Pop")
}
