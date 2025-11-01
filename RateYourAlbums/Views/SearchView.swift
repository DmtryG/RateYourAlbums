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
                
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if viewModel.searchResults.isEmpty &&
                            !viewModel.searchQuery.isEmpty {
                    EmptyStateView(icon: "magnifyingglass", titleText: "Nothing found", bodyText: "Try changing your search query")
                } else if viewModel.searchResults.isEmpty {
                    EmptyStateView(icon: "music.mic", titleText: "Find your favorite albums", bodyText: "Enter the album title or artist name")
                } else {
                    searchResultsList
                }
            }
            .navigationTitle("Search")
            .onAppear {
                libraryViewModel.setModelContext(modelContext)
            }
            .sheet(item: $selectedAlbum) { album in
                AlbumRatingView(albumDTO: album)
            }
        }
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField ("Album title or artist name", text: $viewModel.searchQuery)
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
        .background(Color(.systemGray6))
        .clipShape(Capsule())
        .padding()
    }
    
    private var searchResultsList: some View {
        ScrollView {
            LazyVStack (spacing: 12) {
                ForEach (viewModel.searchResults) { album in
                    SearchResultRowView (
                        album: album,
                        isInLibrary: libraryViewModel.albumExists(id: album.id)
                    )
                    .onTapGesture {
                        selectedAlbum = album
                    }
                }
            }
            .padding()
        }
    }
    
    private var loadingView: some View {
        VStack (spacing: 18) {
            ProgressView()
                .scaleEffect(1.5)
            Text ("Searching for albums...")
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
    }
    
    private func errorView(message: String) -> some View {
        VStack (spacing: 18) {
            Image (systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundStyle(.red)
            
            Text ("Error")
                .font(.title2)
                .fontWeight(.semibold)
            Text (message)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button ("Try again") {
                viewModel.performSearch()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SearchView()
}
