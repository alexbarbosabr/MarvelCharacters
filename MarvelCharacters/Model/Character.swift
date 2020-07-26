//
//  Character.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

class Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    var favorite: Bool? = false

    init(id: Int, name: String, description desc: String, thumbnail: Thumbnail, favorite: Bool? = false) {
        self.id = id
        self.name = name
        self.description = desc
        self.thumbnail = thumbnail
        self.favorite = favorite
    }

    public struct Thumbnail: Codable {
        let path: String
        let `extension`: String

        func getImageUrl() -> URL? {
            var securityPath = path
            if !path.contains("https") {
                securityPath = path.replacingOccurrences(of: "http", with: "https")
            }

            let urlString = "\(securityPath).\(self.extension)"
            return URL(string: urlString)
        }
    }

    func setFavorite(_ favorite: Bool) {
        self.favorite = favorite
    }
}
