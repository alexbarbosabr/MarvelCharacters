//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class CharacterListView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        tableView.register(ErrorCell.self, forCellReuseIdentifier: ErrorCell.identifier)
        tableView.contentInset = .init(top: 0, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primaryBackground
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = "CharacterListView"
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
        tableView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor)
    }

    func makeAddicionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
