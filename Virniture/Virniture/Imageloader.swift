//
//  Imageloader.swift
//  Virniture
//
//  Created by Josh Halbert on 7/20/23.
//

import Foundation

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var imageURLs: [URL] = []

    private var cancellable: AnyCancellable?

    // Function to make the API request and update imageURLs with the response
    func makeRequest(selectedStyle: String, selectedRoomType: String, selectedFunction: String, selectedTone: String, selectedLighting: String) {
        let prompt = "https://fun.rawin1.repl.co/virniture/\(selectedStyle) \(selectedRoomType) with \(selectedFunction) , \(selectedTone) tone, \(selectedLighting) lighting, photorealistic"
        let formattedPrompt = prompt.replacingOccurrences(of: " ", with: "_")

        guard let url = URL(string: formattedPrompt) else {
            print("Invalid URL")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [URL].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] imageURLs in
                      self?.imageURLs = imageURLs
                  })
    }
}

