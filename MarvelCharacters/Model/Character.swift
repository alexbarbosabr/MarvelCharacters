//
//  Character.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    let description: String
    let thumbnail: Thumbnail

    public struct Thumbnail: Codable {
        let path: String
        let `extension`: String

        func getImageUrl() -> URL? {
            let urlString = "\(path).\(self.extension)"
            return URL(string: urlString)
        }
    }
}
