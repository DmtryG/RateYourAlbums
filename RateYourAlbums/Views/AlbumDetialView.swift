//
//  AlbumDetialView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI
import SwiftData

struct AlbumDetialView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let album: Album
    
    @State private var currentRating: Double
    @State private var showingDeleteConfirmation = false
    @State private var isEditingRating = false
    
    init(album: Album) {
        self.album = album
        _currentRating = State(initialValue: album.rating)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    AlbumCoverView(
                        artworkURL: album.artworkURL,
                        size: 250,
                        cornerRadius: 36
                    )
                    .padding(.top, 16)
                    .shadow(color: .black.opacity(0.6), radius: 15)
                    
                    VStack (spacing: 5) {
                        Text (album.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        Text (album.artistName)
                            .font(.headline)
                            .foregroundStyle(.red)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 40)
                    
                    HStack (spacing: 12) {
                        if let year = album.releaseDate?.prefix(4) {
                            InfoBadge(icon: "calendar", text: String(year))
                        }
                        if let trackCount = album.trackCount {
                            InfoBadge(icon: "music.note.list", text: "\(trackCount) tracks")
                        }
                        if let genre = album.primaryGenreName ?? album.genre {
                            InfoBadge(icon: "music.note", text: genre)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    VStack (spacing: 30) {
                        HStack {
                            Text ("Your rating")
                                .font(.headline)
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    if isEditingRating {
                                        saveRating()
                                    }
                                    isEditingRating.toggle()
                                }
                            } label: {
                                isEditingRating ? Image (systemName: "checkmark") : Image (systemName: "pencil")
                                Text (isEditingRating ? "Done" : "Edit")
                            }
                            .buttonStyle(.borderedProminent)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .tint(.red)
                        }
                        .padding(.horizontal, 20)
                        
                        LargeRatingBadgeView(rating: 9.5, size: 180)
                    }
                    .padding(.vertical, 5)
                }
                Divider()
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                VStack (alignment: .leading, spacing: 12) {
                    Text ("Additional details")
                        .font(.headline)
                    
                    DetailRowView(
                        icon: "clock",
                        title: "Date added",
                        value: formatDate(album.dateAdded)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                Button (role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    HStack {
                        Image (systemName: "trash")
                        Text ("Delete from library")
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
    }
    
    private func saveRating() {
        album.rating = currentRating
        try? modelContext.save()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }
    
    private func deleteAlbum () {
        modelContext.delete(album)
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    AlbumDetialView(album: Album(
        id: "1",
        title: "Abbey Road",
        artistName: "The Beatles",
        artworkURL: nil, releaseDate: "1969",
        genre: "Pop",
        trackCount: 14,
        rating: 9.5
    ))
}
