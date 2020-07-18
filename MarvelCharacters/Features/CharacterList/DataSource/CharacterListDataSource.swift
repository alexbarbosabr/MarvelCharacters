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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]

        let cell = UITableViewCell(frame: .zero)
        cell.textLabel?.text = character.name

        return cell
    }
}
