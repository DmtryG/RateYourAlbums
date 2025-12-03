//
//  SecondaryButtonView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 03.12.2025.
//

import SwiftUI

struct SecondaryButtonView: View {
    let image: String
    
    var body: some View {
        Button {
            print ("something")
        } label: {
            HStack {
                Image (systemName: image)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
        }
        .buttonStyle(.glass)
        .tint(.accent)
    }
}

#Preview {
    SecondaryButtonView(image: "clock.fill")
}
