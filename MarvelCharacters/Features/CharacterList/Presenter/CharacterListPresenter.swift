//
//  CharacterListPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol CharacterListPresenterProtocol {
    func fetchCharacters()
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    let service: CharacterListServiceProtocol
    weak var view: CharacterListViewControllerProtocol?

    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }

    func fetchCharacters() {
        view?.loading()
        service.request { [weak self] (result) in
            switch result {
            case .success(let charactersData):
                self?.view?.showCharacters(charactersData.data.results)
            case .failure(let error):
                let error: NSError = error as NSError
                print("Error code \(error.code)")
                self?.view?.error()
            }
        }
    }
}
