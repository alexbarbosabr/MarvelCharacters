//
//  CharacterListDataSource.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
import UIKit

final class CharacterListDataSource: NSObject, UITableViewDataSource {
    var characters = [Character]()
    weak var delegate: CharacterCellDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        let identifier = CharacterCell.identifier

        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CharacterCell
        cell.setup(character: character, indexPath: indexPath)
        cell.delegate = delegate
        return cell
    }
}
