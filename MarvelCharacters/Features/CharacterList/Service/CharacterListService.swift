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
    func request(offset: Int, limit: Int?, startName: String?, completion: @escaping (CharactersDataResult) -> Void)
    func cancelRequest()
}

struct CharacterListService: CharacterListServiceProtocol {
    private let service: ServiceProtocol

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }

    func request(offset: Int, limit: Int?, startName: String?, completion: @escaping (CharactersDataResult) -> Void) {
        let endpoint = CharactersEndpoint(offset: offset, limit: limit, startName: startName)

        service.request(endpoint: endpoint) { (result: CharactersDataResult) in
            completion(result)
        }
    }

    func cancelRequest() {
        service.cancelRequest()
    }
}
