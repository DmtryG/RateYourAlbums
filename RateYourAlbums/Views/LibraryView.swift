//
//  LibraryView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = LibraryViewModel()
    @State private var selectedAlbum: Album?
    @State private var showingAlbumDetail = false
    
    var body: some View {
        NavigationStack {
            
        }
    }
}

#Preview {
}
