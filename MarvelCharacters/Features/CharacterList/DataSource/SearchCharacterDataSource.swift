//
//  SearchCharacterDataSource.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 20/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
import UIKit

final class SearchCharacterDataSource: NSObject, UITableViewDataSource {
    var data: CharactersDataViewModel = .empty
    weak var delegate: CharacterCellDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CharacterCell.identifier

        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CharacterCell
        let character = data.characters[indexPath.row]
        cell.setup(character: character, indexPath: indexPath)
        cell.delegate = delegate
        return cell
    }
}
