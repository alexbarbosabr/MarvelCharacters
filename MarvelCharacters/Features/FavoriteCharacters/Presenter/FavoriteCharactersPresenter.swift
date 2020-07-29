//
//  FavoriteCharactersPresenter.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol FavoriteCharactersPresenterProtocol {
    func fetchCharacters()
    func removeFavorite(indexPath: IndexPath)
}

final class FavoriteCharactersPresenter: FavoriteCharactersPresenterProtocol {
    private let manage = ManageCharacterEmtity()
    private var characters: [Character]
    weak var view: FavoriteCharactersViewProtocol?

    init(characters: [Character] = [Character]()) {
        self.characters = characters
    }

    func fetchCharacters() {
        let characterList = manage.fetchCharacters()
        characters = parseCharacters(characterList)

        if characters.count > 0 {
            view?.showCharacters(characters)
        } else {
            view?.showEmptyList()
        }
    }

    private func parseCharacters(_ characters: [CharacterEntity]) -> [Character] {
        var list = [Character]()

        for item in characters {
            let thumbnail = Character.Thumbnail(path: item.path, extension: item.extension)
            let character = Character(id: Int(item.id),
                                      name: item.name,
                                      description: item.desc,
                                      thumbnail: thumbnail,
                                      favorite: item.favorite)
            list.append(character)
        }

        if list.count == 0 {
            list = self.characters
        }

        return list
    }

    func removeFavorite(indexPath: IndexPath) {
        let character = characters[indexPath.row]

        manage.delete(with: character)

        characters.remove(at: indexPath.row)

        fetchCharacters()
    }
}
