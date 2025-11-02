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
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    sortMenu
                }
            }
            .onAppear {
                viewModel.setModelContext(modelContext)
                viewModel.fetchAlbums()
            }
            .onChange(of: viewModel.selectedSortOption) { _, _ in
                viewModel.fetchAlbums()
            }
            .sheet(item: $selectedAlbum) { album in
                AlbumDetialView(album: album)
            }
        }
    }
    
    private var albumList: some View {
        ScrollView {
            LazyVStack (spacing: 10, pinnedViews: [.sectionHeaders]) {
                ForEach (viewModel.albumsByMonth, id: \.monthYear) { section in
                    Section {
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
                    } header: {
                        HStack {
                            Text (section.monthYear)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
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
    let calendar = Calendar.current
    let now = Date()
    
    let album1 = Album(
        id: "1",
        title: "Abbey Road",
        artistName: "The Beatles",
        artworkURL: nil,
        rating: 9.5,
        dateAdded: now
    )
    
    let album2 = Album(
        id: "2",
        title: "Dark Side of the Moon",
        artistName: "Pink Floyd",
        artworkURL: nil,
        rating: 10.0,
        dateAdded: calendar.date(byAdding: .month, value: -1, to: Date())!
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
