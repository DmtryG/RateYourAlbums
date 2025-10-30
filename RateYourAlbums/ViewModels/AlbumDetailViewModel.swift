//
//  AlbumDetailViewModel.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import Foundation
import SwiftData

@Observable
class AlbumDetailViewModel {
    var album: Album?
    var albumDTO: AlbumDTO?
    var isInLibrary = false
    var currentRating: Double = 5.0
    
    private var modelContext: ModelContext?
    
    func setModelContext (_ context: ModelContext) {
        self.modelContext = context
    }
    
    func loadAlbum (albumId: String? = nil, dto: AlbumDTO? = nil) {
        guard let modelContext = modelContext else {
            return
        }
        
        if let albumId = albumId {
            let descriptor = FetchDescriptor<Album>(
                predicate: #Predicate{ album in
                    album.id == albumId
                }
            )
            
            do {
                let albums = try modelContext.fetch(descriptor)
                album = albums.first
                isInLibrary = album != nil
                currentRating = album?.rating ?? 5.0
            } catch {
                print ("Error loading album: \(error)")
            }
        }
        
        if album == nil, let dto = dto {
            albumDTO = dto
            currentRating = 5.0
            
            let descriptor = FetchDescriptor<Album>(
                predicate: #Predicate{ album in
                    album.id == dto.id
                }
            )
            
            do {
                let albums = try modelContext.fetch(descriptor)
                if let existingAlbum = albums.first {
                    album = existingAlbum
                    isInLibrary = true
                    currentRating = existingAlbum.rating
                }
            } catch {
                print ("Error checking album: \(error)")
            }
        }
    }
    
    func saveAlbum() {
        guard let modelContext = modelContext else {
            return
        }
        
        if let album = album {
            album.rating = currentRating
            try? modelContext.save()
        } else if let albumDTO = albumDTO {
            let newAlbum = albumDTO.toAlbum(rating: currentRating)
            modelContext.insert(newAlbum)
            try? modelContext.save()
            
            album = newAlbum
            isInLibrary = true
        }
    }
    
    func deleteAlbum() {
        guard let modelContext = modelContext, let album = album else {
            return
        }
        
        modelContext.delete(album)
        try? modelContext.save()
        
        isInLibrary = false
        self.album = nil
    }
    
    func updateRating(_ newRating: Double) {
        currentRating = newRating
        
        if let album = album {
            album.rating = newRating
            try? modelContext?.save()
        }
    }
}
