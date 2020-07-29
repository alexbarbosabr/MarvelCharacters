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
    var data: CharactersDataViewModel = .empty
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
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: identifier,
                    for: indexPath) as? ErrorCell else {
                        fatalError("Could not use cell with identifier: \(ErrorCell.identifier)")
                }
                return cell
            }

            let identifier = LoadingCell.identifier
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath) as? LoadingCell else {
                    fatalError("Could not use cell with identifier: \(LoadingCell.identifier)")
            }
            cell.startLoading()
            return cell
        }

        let identifier = CharacterCell.identifier

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath) as? CharacterCell else {
                fatalError("Could not use cell with identifier: \(CharacterCell.identifier)")
        }
        let character = data.characters[indexPath.row]
        cell.setup(character: character, indexPath: indexPath)
        cell.delegate = delegate
        return cell
    }
}
