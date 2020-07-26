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
    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?) {
        let manageDAO = ManageCharacterDAO()

        if isFavorite {
            manageDAO.save(with: character, imageData: imageData)
        } else {
            manageDAO.delete(with: character)
        }
    }
}
