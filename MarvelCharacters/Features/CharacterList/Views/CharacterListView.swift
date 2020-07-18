//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class CharacterListView: UIView {
    let tableView = UITableView()

    init() {
        super.init(frame: .zero)
        makeView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterListView: CodeView {
    func buildViewHierarchy() {
        addSubview(tableView)
    }

    func makeContraints() {
        tableView.fillSuperView()
    }
}
