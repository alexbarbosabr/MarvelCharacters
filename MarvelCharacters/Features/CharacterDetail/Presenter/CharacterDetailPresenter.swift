//
//  CharacterDetailPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol CharacterDetailPresenterProtocol {
    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?)
}

final class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    weak var view: CharacterDetailViewProtocol?

    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?) {
        let manage = ManageCharacterEmtity()

        if isFavorite {
            do {
                try manage.save(with: character, imageData: imageData)
            } catch {
                view?.showSaveFavoriteError()
            }
        } else {
            do {
                try manage.delete(with: character)
            } catch {
                view?.showRemoveFavoriteError()
            }
        }
    }
}
