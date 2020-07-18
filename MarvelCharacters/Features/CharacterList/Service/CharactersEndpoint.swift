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
}
