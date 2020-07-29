//
//  FavoriteCharactersDataSource.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class FavoriteCharactersDataSource: NSObject, UITableViewDataSource {
    var characters = [Character]()
    weak var delegate: CharacterCellDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.identifier,
            for: indexPath) as? CharacterCell else {
                fatalError("Could not use cell with identifier: \(CharacterCell.identifier)")
        }

        let character = characters[indexPath.row]

        cell.setup(character: character, indexPath: indexPath)
        cell.delegate = delegate
        return cell
    }
}
