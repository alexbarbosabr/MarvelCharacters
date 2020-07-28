//
//  Character+Extension.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

@testable import MarvelCharacters

extension Character {
    static func mockWithHttpUrl() -> Character {
        let thumbnail = Character.Thumbnail(path: "http://xxxx", extension: "jpg")
        let mock = Character(id: 1,
                             name: "Spider-man",
                             description: "",
                             thumbnail: thumbnail)
        return mock
    }

    static func mockWithHttpsUrl() -> Character {
        let thumbnail = Character.Thumbnail(path: "https://xxxx", extension: "jpg")
        let mock = Character(id: 1,
                             name: "Spider-man",
                             description: "Bitten by a radioactive spider, high school student Peter Parker...",
                             thumbnail: thumbnail)
        return mock
    }

    static func mockWithNilUrl() -> Character {
        let thumbnail = Character.Thumbnail(path: "https:\\xxxx", extension: "jpg")
        let mock = Character(id: 1,
                             name: "Spider-man",
                             description: "",
                             thumbnail: thumbnail)
        return mock
    }
}
