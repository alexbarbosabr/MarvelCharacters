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
        let host = "https://gateway.marvel.com:443/"
        let api = "v1/public/characters"
        let paramOne = "ts=1"
        let paramTwo = "apikey=a9e65ff2d46c8fa20e09199a07d5d6c6"
        let paramThree = "hash=1380e7daf0062f1634a180983f0dba67"
        let urlString = "\(host)\(api)?\(paramOne)&\(paramTwo)&\(paramThree)"

        guard let url = URL(string: urlString) else { return }

        service.request(url: url, httpMethod: .get) { (result: CharactersDataResult) in
            completion(result)
        }
    }
}
