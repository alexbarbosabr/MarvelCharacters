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
    var data = CharactersDataViewModel(offset: 0, total: 0, count: 0, characters: [Character]())
    weak var delegate: CharacterCellDelegate?
    var showError: Bool = false

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // total to show only one loading or error cell
        var total = data.characters.count + 1

        if data.characters.count == data.total {
            total = data.characters.count
        }

        return total
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CharacterListViewController.isLoadingCell(for: indexPath, currentCount: data.characters.count) {
            if showError {
                let identifier = ErrorCell.identifier
                // swiftlint:disable:next force_cast
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ErrorCell
                return cell
            }

            let identifier = LoadingCell.identifier
            // swiftlint:disable:next force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LoadingCell
            cell.startLoading()
            return cell
        }

        let identifier = CharacterCell.identifier

        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CharacterCell
        let character = data.characters[indexPath.row]
        cell.setup(character: character, indexPath: indexPath)
        cell.delegate = delegate
        return cell
    }
}
