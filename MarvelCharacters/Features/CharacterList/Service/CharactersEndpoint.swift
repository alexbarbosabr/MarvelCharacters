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

    init(offset: Int? = nil, limit: Int? = nil, startName: String? = nil) {
        var finalLimit = String(CharactersEndpoint.limit)

        if let limit = limit {
            finalLimit = String(limit)
        }

        parameters["limit"] = finalLimit
        parameters["offset"] = String(offset ?? 0)

        if let name = startName {
            parameters["nameStartsWith"] = name
        }
    }
}
