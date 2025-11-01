//
//  AlbumRatingView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.11.2025.
//

import SwiftUI
import SwiftData

struct AlbumRatingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let albumDTO: AlbumDTO
    
    @State private var rating: Double = 7.0
    @State private var showingSaveConfirmation = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    AlbumCoverView(
                        artworkURL: albumDTO.artworkUrl100?.replacingOccurrences(of: "100x100", with: "600x600"),
                        size: 250,
                        cornerRadius: 36
                    )
                    .padding(.top, 16)
                    .shadow(color: .black.opacity(0.6), radius: 15)
                    
                    VStack (spacing: 5) {
                        Text (albumDTO.collectionName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                        Text (albumDTO.artistName)
                            .font(.headline)
                            .foregroundStyle(.red)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 40)
                    
                    HStack (spacing: 12) {
                        if let year = albumDTO.releaseDate?.prefix(4) {
                            InfoBadge(icon: "calendar", text: String(year))
                        }
                        if let trackCount = albumDTO.trackCount {
                            InfoBadge(icon: "music.note.list", text: "\(trackCount) tracks")
                        }
                        if let genre = albumDTO.primaryGenreName ?? albumDTO.primaryGenreName {
                            InfoBadge(icon: "music.note", text: genre)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    VStack (spacing: 30) {
                        Text ("Your rating")
                            .font(.headline)
                        
                        RatingEditorView(rating: $rating)
                    }
                    .padding(.vertical, 5)
                    
                    Button {
                        saveAlbum()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text ("Add to library")
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity)
                    }
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.horizontal, 20)
                    .padding(.top, 1)
                }
            }
            .navigationTitle("Rate the album")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .alert("Album added", isPresented: $showingSaveConfirmation) {
                Button ("Ok") {
                    dismiss()
                }
            } message: {
                Text("\(albumDTO.collectionName) was added to your library with a rating \(String(format: "%.1f", rating))")
            }
        }
    }
    
    private func saveAlbum() {
        let album = albumDTO.toAlbum(rating: rating)
        modelContext.insert(album)
        
        do {
            try modelContext.save()
            showingSaveConfirmation = true
        } catch {
            print ("Error saving album: \(error)")
        }
    }
}

#Preview {
    let sampleAlbum = AlbumDTO(
        collectionId: 1,
        collectionName: "Abbey Road",
        artistName: "The Beatles",
        artworkUrl100: nil,
        artworkUrl60: nil,
        releaseDate: "1969-09-26T07:00:00Z",
        primaryGenreName: "Rock",
        trackCount: 17,
        copyright: nil,
        collectionPrice: 9.99,
        currency: "USD",
        collectionViewUrl: nil,
        country: "USA"
    )
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Album.self, configurations: config)
    
    return AlbumRatingView(albumDTO: sampleAlbum)
        .modelContainer(container)
}
