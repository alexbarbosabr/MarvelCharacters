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
    func fetchFavoriteCharacters()
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    private let service: CharacterListServiceProtocol
    private let manageData: ManageCharacterEmtityProtocol
    private var isFetchInProgress = false
    private var offset = 0
    weak var view: CharacterListViewProtocol?

    private var charactersDataView: CharactersDataViewModel = .empty

    init(service: CharacterListServiceProtocol = CharacterListService(),
         manageData: ManageCharacterEmtityProtocol = ManageCharacterEmtity()) {
        self.service = service
        self.manageData = manageData
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

    func fetchFavoriteCharacters() {
        updateBadge()
    }

    func updateCharactersWhenSetFavoriteInOtherContext() {
        updateFavoriteCharacters()
        updateBadge()
        view?.refreshTable(self.charactersDataView)
    }

    func setFavorite(indexPath: IndexPath, isFavorite: Bool, imageData: Data?) {
        let character = charactersDataView.characters[indexPath.row]
        character.setFavorite(isFavorite)

        if isFavorite {
            manageData.save(with: character, imageData: imageData)
        } else {
            manageData.delete(with: character)
        }

        view?.updateCell(index: indexPath)
        updateBadge()
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

    private func updateBadge() {
        let characters = manageData.fetchCharacters()

        view?.updateBadgeFavoriteButton(amount: characters.count)
    }

    private func updateFavoriteCharacters() {
        let characters = manageData.fetchCharacters()

        var ids = [Int]()

        for favorite in characters {
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
}
