//
//  AsyncImageView.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-19.
//

import UIKit
import SwiftUI

struct AsyncImageView: View {
    @State private var uiImage: UIImage? = nil
    let url: URL?
    let identifier: String
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        ImageLoader.shared.loadImage(from: url, identifier: identifier) { image in
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}
