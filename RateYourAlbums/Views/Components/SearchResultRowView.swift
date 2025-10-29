//
//  SearchResultRowView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftUI

struct SearchResultRowView: View {
    let album: AlbumDTO
    let isInLibrary: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            AlbumCoverView(
                artworkURL: album.artworkUrl100,
                size: 70,
                cornerRadius: 18
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(album.collectionName)
                    .font(.headline)
                    .lineLimit(1)
                Text (album.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.red.opacity(0.8))
                    .lineLimit(1)
                
                HStack (spacing: 4) {
                    if let year = album.releaseDate?.prefix(4) {
                        HStack (spacing: 2) {
                            Image(systemName: "calendar")
                                .font(.caption2)
                            Text(String(year))
                                .font(.caption)
                        }
                        .foregroundStyle(.secondary)
                    }
                    
                    if let genre = album.primaryGenreName {
                        HStack (spacing: 2) {
                            Image(systemName: "music.note")
                                .font(.caption2)
                            Text(String(genre))
                                .font(.caption)
                        }
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 10)
                    }
                }
            }
            
            Spacer()
            
            if isInLibrary {
                VStack (spacing: 2) {
                    Image (systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                }
            }
        }
        .padding(10)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.1), radius: 8)
    }
}
