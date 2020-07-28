//
//  CharacterListServiceStub.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class CharacterListServiceStub: CharacterListServiceProtocol {
    var shouldReturnsError: ServiceError?
    var shouldReturnsEmptyList: Bool = false

    func request(offset: Int, limit: Int?, startName: String?, completion: @escaping (CharactersDataResult) -> Void) {

        if shouldReturnsError == nil {
            let mockCharacter = Character.mockWithHttpUrl()
            let mockCharacters = !shouldReturnsEmptyList ? [mockCharacter] : []
            let mockData = CharactersData.CharacterData(offset: 0,
                                                        limit: 0,
                                                        total: mockCharacters.count,
                                                        count: mockCharacters.count,
                                                        results: mockCharacters)
            let mock = CharactersData(data: mockData)

            completion(.success(mock))
            return
        }

        completion(.failure(shouldReturnsError!))
    }

    func cancelRequest() {}
}
