//
//  CharacterListPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol CharacterListPresenterProtocol {
    func fetchCharacters(showScreenLoading: Bool)
    func setFavorite(indexPath: IndexPath, isFavorite: Bool, imageData: Data?)
    func updateCharactersWhenSetFavoriteInOtherContext()
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    private let service: CharacterListServiceProtocol
    private var isFetchInProgress = false
    private var offset = 0
    weak var view: CharacterListViewProtocol?

    private var charactersDataView: CharactersDataViewModel = .empty

    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }

    func fetchCharacters(showScreenLoading: Bool) {
        guard !isFetchInProgress else {
          return
        }

        if showScreenLoading {
            view?.showLoadingOnScreen()
        }

        isFetchInProgress = true
        service.request(offset: offset, limit: nil, startName: nil) { [weak self] (result) in
            guard let self = self else { return }
            self.isFetchInProgress = false

            switch result {
            case .success(let charactersData):
                self.updateCharacters(charactersData: charactersData)
                if charactersData.data.results.count == 0 {
                    self.view?.showEmptyList(withIcon: .emptyList,
                                             message: L10n.CharacterList.noCharactersFound)
                } else {
                    self.updateFavoriteCharacters()
                    self.view?.showCharacters(self.charactersDataView)
                }
            case .failure(let error):
                if showScreenLoading {
                    self.handleError(error)
                } else {
                    self.view?.showErrorOnTableView()
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        let error: NSError = error as NSError
        let code = ServiceError(rawValue: error.code)

        if code == .noInternet {
            self.view?.showErrorOnScreen(withIcon: .noInternet, message: L10n.Message.noInternet)
        } else {
            self.view?.showErrorOnScreen(withIcon: .generic, message: L10n.Message.generic)
        }
    }

    private func updateCharacters(charactersData: CharactersData) {
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

    func setFavorite(indexPath: IndexPath, isFavorite: Bool, imageData: Data?) {
        let manageDAO = ManageCharacterDAO()

        let character = charactersDataView.characters[indexPath.row]
        character.setFavorite(isFavorite)

        if isFavorite {
            manageDAO.save(with: character, imageData: imageData)
        } else {
            manageDAO.delete(with: character)
        }

        view?.updateCell(index: indexPath)
    }

    private func updateFavoriteCharacters() {
        let manageDAO = ManageCharacterDAO()
        let favorites = manageDAO.fetchCharacters()

        var ids = [Int]()

        for favorite in favorites {
            ids.append(Int(favorite.id))
        }

        for character in charactersDataView.characters {
            if ids.contains(character.id) {
                character.setFavorite(true)
            } else {
                character.setFavorite(false)
            }
        }
    }

    func updateCharactersWhenSetFavoriteInOtherContext() {
        updateFavoriteCharacters()
        view?.refreshTable(self.charactersDataView)
    }
}
