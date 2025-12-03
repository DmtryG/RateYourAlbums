//
//  PrimaryButtonView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 03.12.2025.
//

import SwiftUI

struct PrimaryButtonView: View {
    let image: String
    let text: String
    
    var body: some View {
        Button {
            print ("placeholder")
        } label: {
            HStack {
                Image (systemName: image)
                Text (text)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .padding(.horizontal, 50)
            .padding(.vertical, 15)
        }
        .buttonStyle(.glassProminent)
    }
}

#Preview {
    PrimaryButtonView(image: "plus", text: "Save to rated")
}
