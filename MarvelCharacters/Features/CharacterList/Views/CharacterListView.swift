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
        tableView.contentInset = .init(top: 0, left: 0, bottom: 8, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.backgroundView?.backgroundColor = .clear
        return tableView
    }()

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

    func makeAddicionalConfiguration() {
        backgroundColor = .primaryBackground
    }
}
