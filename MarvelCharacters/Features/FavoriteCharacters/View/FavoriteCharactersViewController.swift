//
//  FavoriteCharactersViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

protocol FavoriteCharactersViewProtocol: AnyObject {
    func showEmptyList()
    func showCharacters(_ characters: [Character])
    func showRemoveFavoriteError()
}

protocol FavoriteCharactersNavigatorListener {
    func goToDetail(character: Character)
}

final class FavoriteCharactersViewController: UIViewController {
    private let presenter: FavoriteCharactersPresenterProtocol
    private let navigatorListener: FavoriteCharactersNavigatorListener

    private lazy var characterListView: CharacterListView = {
        let view = CharacterListView()
        view.tableView.delegate = self
        view.tableView.dataSource = dataSource
        view.tableView.accessibilityIdentifier = "FavoriteCharactersTableView"
        return view
    }()

    private lazy var dataSource: FavoriteCharactersDataSource = {
        let dataSource = FavoriteCharactersDataSource()
        dataSource.delegate = self
        return dataSource
    }()

    init(presenter: FavoriteCharactersPresenterProtocol, navigatorListener: FavoriteCharactersNavigatorListener) {
        self.presenter = presenter
        self.navigatorListener = navigatorListener
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.FavoriteCharacters.title

        let backButton = UIBarButtonItem(image: Icon.back.image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))

        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchCharacters()
    }

    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension FavoriteCharactersViewController: FavoriteCharactersViewProtocol {
    func showEmptyList() {
        let empty = MessageView()
        empty.accessibilityIdentifier = "FavoriteCharactersEmptyView"
        empty.setIcon(.heart)
        empty.message = L10n.FavoriteCharacters.Message.empty
        view = empty
    }

    func showCharacters(_ characters: [Character]) {
        dataSource.characters = characters
        characterListView.tableView.reloadData()
        view = characterListView
    }

    func showRemoveFavoriteError() {
        showAlert(title: L10n.Message.Title.generic, message: L10n.Message.Error.removeFavorite)
    }
}

extension FavoriteCharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.heightRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = dataSource.characters[indexPath.row]
        navigatorListener.goToDetail(character: character)
    }
}

extension FavoriteCharactersViewController: CharacterCellDelegate {
    func tapFavoriteButton(index: IndexPath, isFavorite: Bool, imageData: Data?) {
        presenter.removeFavorite(indexPath: index)
    }
}
