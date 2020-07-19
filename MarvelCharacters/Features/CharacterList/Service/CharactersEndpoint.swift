//
//  CharactersEndpoint.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

struct CharactersEndpoint: Endpoint {
    var apiPath: String = "/v1/public/characters"

    var parameters: [String: Any] = [:]

    init(offset: Int? = 0) {
        parameters["limit"] = "100"
        parameters["offset"] = String(offset ?? 0)
    }
}
