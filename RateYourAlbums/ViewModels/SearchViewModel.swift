//
//  SearchViewModel.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import Foundation

@Observable
class SearchViewModel {
    var searchQuery = ""
    var searchResults: [AlbumDTO] = []
    var isLoading = false
    var errorMessage: String?
    
    private let apiService = iTunesAPIService.shared
    private var searchTask: Task<Void, Never>?
    
    func performSearch() {
        searchTask?.cancel()
        
        guard !searchQuery.isEmpty else {
            searchResults = []
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            guard !Task.isCancelled else {
                return
            }
            await executeSearch()
        }
    }
    
    @MainActor
    private func executeSearch() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let results = try await apiService.searchAlbums(query: searchQuery)
            
            if !Task.isCancelled {
                searchResults = results
            }
        } catch {
            if !Task.isCancelled {
                errorMessage = error.localizedDescription
                searchResults = []
            }
        }
        
        isLoading = false
    }
    
    func clearSearch() {
        searchTask?.cancel()
        searchQuery = ""
        searchResults = []
        errorMessage = nil
    }
}
