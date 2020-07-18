//
//  CharacterListService.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
typealias CharactersDataResult = Result<CharactersData, Error>

protocol CharacterListServiceProtocol {
    func request(completion: @escaping (CharactersDataResult) -> Void)
}

struct CharacterListService: CharacterListServiceProtocol {
    private let service: ServiceProtocol

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }

    func request(completion: @escaping (CharactersDataResult) -> Void) {
        let endpoint = CharactersEndpoint()

        service.request(endpoint: endpoint) { (result: CharactersDataResult) in
            completion(result)
        }
    }
}
