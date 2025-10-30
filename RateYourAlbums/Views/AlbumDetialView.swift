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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

