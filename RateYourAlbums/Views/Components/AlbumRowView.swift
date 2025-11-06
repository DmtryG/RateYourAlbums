//
//  AlbumRowView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album
    
    var body: some View {
        HStack (spacing: 12) {
            AlbumCoverView(
                artworkURL: album.artworkURL,
                size: 70,
                cornerRadius: 18
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(album.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text (album.artistName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.red.opacity(0.8))
                    .lineLimit(1)
            }
            
            Spacer()
            
            RatingBadgeView(
                rating: album.rating,
                size: 60
            )
        }
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.1), radius: 8)
    }
}

#Preview {
    AlbumRowView(album: Album(
        id: "1",
        title: "Abbey Road",
        artistName: "The Beatles",
        artworkURL: nil,
        rating: 9.5
    ))
}
