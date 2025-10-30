//
//  SearchView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = SearchViewModel()
    @State private var libraryViewModel = LibraryViewModel()
    @State private var selectedAlbum: AlbumDTO?
    @State private var showingRatingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0) {
                searchField
            }
        }
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField ("Album name or artist name", text: $viewModel.searchQuery)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .onChange(of: viewModel.searchQuery) { _, _ in
                    viewModel.performSearch()
                }
            
            if !viewModel.searchQuery.isEmpty {
                Button {
                    viewModel.clearSearch()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray.opacity(0.6))
                }
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(Capsule())
        .padding()
    }
}

#Preview {
    SearchView()
}
