//
//  AlbumRowView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album
    
    var body: some View {
        HStack {
            AlbumCoverView(coverName: "rosie")
                .padding(.horizontal, 11)
            
            VStack (alignment: .leading){
                Text (album.title)
                    .albumTitleStyle()
                Text (album.artistName)
                    .artistNameStyle()
            }
            
            Spacer()
            
            RatingBadgeView(rating: album.rating, size: 70)
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
    ZStack {
        Color.background
        AlbumRowView(album: Album(id: UUID(), title: "rosie", artistName: "ROSÉ", releaseYear: "2024", genre: "Pop", cover: "rosie", rating: 9.4))
    }
}

