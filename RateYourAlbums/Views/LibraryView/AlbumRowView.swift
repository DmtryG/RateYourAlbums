//
//  AlbumRowView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct AlbumRowView: View {
    var body: some View {
        HStack {
            AlbumCoverView()
                .padding(.horizontal, 11)
            
            VStack (alignment: .leading){
                Text ("rosie")
                    .albumTitleStyle()
                    .lineLimit(1)
                Text ("ROSÉ")
                    .artistNameStyle()
                    .lineLimit(1)
            }
            
            Spacer()
            
            RatingBadgeView()
                .padding(.horizontal, 11)
        }
        .frame(width: .infinity, height: 100)
        .background (
            RoundedRectangle(cornerRadius: 26)
        )
        .foregroundStyle(LinearGradient(colors: [Color.gradientColor1, Color.gradientColor2], startPoint: .top, endPoint: .bottom))
        .overlay (
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color.border, lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    AlbumRowView()
}
