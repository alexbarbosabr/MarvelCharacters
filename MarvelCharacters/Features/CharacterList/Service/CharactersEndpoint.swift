//
//  CharactersEndpoint.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

struct CharactersEndpoint: Endpoint {
    static let limit = 30
    var apiPath: String = "/v1/public/characters"

    var parameters: [String: Any] = [:]

    init(offset: Int?) {
        parameters["limit"] = String(CharactersEndpoint.limit)
        parameters["offset"] = String(offset ?? 0)
    }
}
