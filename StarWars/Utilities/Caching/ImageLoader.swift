//
//  ImageLoader.swift
//  StarWars
//
//  Created by Gunawardana, Bagya Nuwanthi on 2025-08-19.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let fileManager = FileManager.default

    private init() {}

    func loadImage(from url: URL, identifier: String,forceRefresh: Bool = false, completion: @escaping (UIImage?) -> Void) {

        let filePath = pathForImage(identifier: identifier)

        // Check if the image exists on disk
        if !forceRefresh, let diskImage = UIImage(contentsOfFile: filePath.path) {
            completion(diskImage)
            return
        }

        // Downloading the image
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            // Save the image to disk with the identifier
            try? data.write(to: filePath)

            // Return the image
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    private func pathForImage(identifier: String) -> URL {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent(identifier)
    }
}
