//
//  SearchCharacterPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 21/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol SearchCharacterPresenterProtocol {
    func fetchCharacter(name: String)
}

final class SearchCharacterPresenter: SearchCharacterPresenterProtocol {
    private let service: CharacterListServiceProtocol
    weak var view: SearchCharacterViewControllerProtocol?

    private var charactersDataView: CharactersDataViewModel = .empty

    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }

    func fetchCharacter(name: String) {
        view?.showLoading()
        service.cancelRequest()
        service.request(offset: 0, limit: 100, startName: name) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let charactersData):
                let data = CharactersDataViewModel(offset: charactersData.data.offset,
                                                   total: charactersData.data.total,
                                                   count: charactersData.data.count,
                                                   characters: charactersData.data.results)
                self.view?.hideLoading()

                if data.characters.count > 0 {
                    self.view?.showCharacters(data)
                } else {
                    self.view?.showEmptyCharacters()
                }
            case .failure(let error):
                let error: NSError = error as NSError

                if error.code != -999 {
                    self.view?.hideLoading()
                    self.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        let error: NSError = error as NSError
        if error.code == -1009 {
            self.view?.showError(withIcon: .noInternet, message: L10n.Message.noInternet)
        } else {
            self.view?.showError(withIcon: .generic, message: L10n.Message.generic)
        }
    }
}
