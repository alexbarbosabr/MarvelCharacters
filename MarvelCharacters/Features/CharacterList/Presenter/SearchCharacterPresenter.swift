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
    func setFavorite(indexPath: IndexPath, isFavorite: Bool, imageData: Data?)
    func updateCharactersWhenSetFavoriteInOtherContext()
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
                self.charactersDataView = data
                self.updateFavoriteCharacters()

                self.view?.hideLoading()

                if data.characters.count > 0 {
                    self.view?.showCharacters(data)
                } else {
                    self.view?.showEmptyCharacters()
                }
            case .failure(let error):
                    self.handleError(error)
            }
        }
    }

    private func handleError(_ error: Error) {
        let error: NSError = error as NSError
        let code = ServiceError(rawValue: error.code)

        guard code != .cancelRequest else { return }
        self.view?.hideLoading()

        if code == .noInternetConnection {
            self.view?.showError(withIcon: .noInternet, message: L10n.Message.noInternet)
        } else {
            self.view?.showError(withIcon: .generic, message: L10n.Message.generic)
        }
    }

    private func updateFavoriteCharacters() {
        let manage = ManageCharacterEmtity()
        let favorites = manage.fetchCharacters()

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

    func setFavorite(indexPath: IndexPath, isFavorite: Bool, imageData: Data?) {
        let manage = ManageCharacterEmtity()

        let character = charactersDataView.characters[indexPath.row]
        character.setFavorite(isFavorite)

        if isFavorite {
            do {
                try manage.save(with: character, imageData: imageData)

                view?.updateCell(index: indexPath)
            } catch {
                view?.showSaveFavoriteError()
            }
        } else {
            do {
                try manage.delete(with: character)

                view?.updateCell(index: indexPath)
            } catch {
                view?.showRemoveFavoriteError()
            }
        }
    }

    func updateCharactersWhenSetFavoriteInOtherContext() {
        updateFavoriteCharacters()
        view?.showCharacters(charactersDataView)
    }
}
