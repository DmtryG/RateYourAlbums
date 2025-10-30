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
    
}
