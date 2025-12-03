//
//  AdditionalInfoView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 03.12.2025.
//

import SwiftUI

struct AdditionalInfoView: View {
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image (systemName: image)
                .font(.title2)
                .foregroundStyle(.title)
            Text (text)
                .font(.headline)
                .foregroundStyle(.title)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    AdditionalInfoView(image: "star.circle.fill", text: "Your rating")
}
