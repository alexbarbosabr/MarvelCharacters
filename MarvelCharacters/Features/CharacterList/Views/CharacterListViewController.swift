//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

protocol CharacterListViewControllerProtocol: AnyObject {
    func showCharacters(_ characters: [Character])
    func error()
    func loading()
}

final class CharacterListViewController: UIViewController {
    private let presenter: CharacterListPresenterProtocol
    private let characterListView = CharacterListView()
    private let dataSource = CharacterListDataSource()

    init(presenter: CharacterListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        title = L10n.CharacterList.title

        //TODO: Remove this code soon
        let button = UIBarButtonItem(title: "test request",
                                     style: .plain,
                                     target: self,
                                     action: #selector(testRequest))

        navigationItem.rightBarButtonItem = button
    }

    @objc
    private func testRequest() {
        presenter.fetchCharacters()
    }
}

extension CharacterListViewController: CharacterListViewControllerProtocol {
    func showCharacters(_ characters: [Character]) {
        dataSource.characters = characters

        characterListView.tableView.dataSource = dataSource
        characterListView.tableView.reloadData()

        view = characterListView
    }

    func error() {
        print("show error")
    }

    func loading() {
        let loading = LoadingView()
        view = loading
    }
}
