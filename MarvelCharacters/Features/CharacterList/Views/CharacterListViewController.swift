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
        view.backgroundColor = .primaryBackground

        title = L10n.CharacterList.title

        //TODO: Remove this code soon
        let button = UIBarButtonItem(title: "request",
                                     style: .plain,
                                     target: self,
                                     action: #selector(testRequest))

        navigationItem.rightBarButtonItem = button

        presenter.fetchCharacters()
    }

    @objc
    private func testRequest() {
        presenter.fetchCharacters()
    }
}

extension CharacterListViewController: CharacterListViewControllerProtocol {
    func showCharacters(_ characters: [Character]) {
        dataSource.characters = characters
        dataSource.delegate = self

        characterListView.tableView.dataSource = dataSource
        characterListView.tableView.delegate = self
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

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = dataSource.characters[indexPath.row]
        print("go to \(character.name) detail")
    }
}

extension CharacterListViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath?, isFavorite: Bool) {
        if let index = index?.row {
            dataSource.characters[index].setFavorite(isFavorite)
        }
    }
}
