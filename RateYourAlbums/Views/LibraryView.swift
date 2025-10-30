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
            Group {
                if viewModel.filteredAlbums.isEmpty {
                    EmptyStateView(icon: "music.note.list", titleText: "The library is empty", bodyText: "Find albums in the \"Search\" tab and add them to your library")
                } else {
                    albumList
                }
            }
            .navigationTitle("Library")
            .searchable(text: $viewModel.searchText)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Library")
//                        .font(.title)
//                        .fontWidth(.expanded)
//                        .fontWeight(.bold)
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    sortMenu
//                }
//            }
            .onAppear {
                viewModel.setModelContext(modelContext)
                viewModel.fetchAlbums()
            }
            .onChange(of: viewModel.selectedSortOption) { _, _ in
                viewModel.fetchAlbums()
            }
        }
    }
    
    private var albumList: some View {
        ScrollView {
            LazyVStack (spacing: 12) {
                ForEach (viewModel.filteredAlbums, id: \.id) { album in
                    AlbumRowView(album: album)
                        .onTapGesture {
                            selectedAlbum = album
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button (role: .destructive) {
                                withAnimation {
                                    viewModel.deleteAlbum(album)
                                }
                            } label: {
                                Label("Delete", image: "trash")
                            }
                        }
                    
                }
            }
            .padding()
        }
    }
    
    private var sortMenu: some View {
        Menu {
            Picker("Sort", selection: $viewModel.selectedSortOption) {
                ForEach (SortOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
        } label: {
            Image (systemName: "arrow.up.arrow.down")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Album.self, configurations: config)
    
    let album1 = Album(
        id: "1",
        title: "Abbey Road",
        artistName: "The Beatles",
        artworkURL: nil,
        rating: 9.5
    )
    
    let album2 = Album(
        id: "2",
        title: "Dark Side of the Moon",
        artistName: "Pink Floyd",
        artworkURL: nil,
        rating: 10.0
    )
    
    container.mainContext.insert(album1)
    container.mainContext.insert(album2)
    
    return LibraryView()
        .modelContainer(container)
}

#Preview("Empty") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Album.self, configurations: config)
    
    return LibraryView()
        .modelContainer(container)
}
