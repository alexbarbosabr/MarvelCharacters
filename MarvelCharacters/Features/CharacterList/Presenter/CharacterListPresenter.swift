//
//  CharacterListPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol CharacterListPresenterProtocol {
    func fetchCharacters(showLoading: Bool)
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    private let service: CharacterListServiceProtocol
    private var isFetchInProgress = false
    private var offset = 0
    weak var view: CharacterListViewControllerProtocol?

    private var charactersDataView: CharactersDataViewModel = .empty

    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }

    func fetchCharacters(showLoading: Bool) {
        guard !isFetchInProgress else {
          return
        }

        if showLoading {
            view?.loading()
        }

        isFetchInProgress = true
        service.request(offset: offset, limit: nil, startName: nil) { [weak self] (result) in
            guard let self = self else { return }
            self.isFetchInProgress = false

            switch result {
            case .success(let charactersData):
                self.updateCharacters(charactersData: charactersData)
                self.view?.showCharacters(self.charactersDataView)
            case .failure(let error):
                let error: NSError = error as NSError
                print("Error code \(error.code)")
                self.view?.error(didShowLoading: showLoading)
            }
        }
    }

    func updateCharacters(charactersData: CharactersData) {
        if charactersDataView.characters.count == 0 {
            charactersDataView = CharactersDataViewModel(offset: charactersData.data.offset,
                                                         total: charactersData.data.total,
                                                         count: charactersData.data.count,
                                                         characters: charactersData.data.results)
        } else {
            let characters = charactersDataView.characters + charactersData.data.results
            let count = characters.count

            let data = CharactersDataViewModel(offset: offset,
                                               total: charactersData.data.total,
                                               count: count,
                                               characters: characters)

            charactersDataView = data
        }

        offset = charactersData.data.offset + CharactersEndpoint.limit
    }
}
