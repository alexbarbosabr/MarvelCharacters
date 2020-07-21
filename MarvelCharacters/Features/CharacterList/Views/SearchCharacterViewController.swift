//
//  SearchCharacterViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 20/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

protocol SearchCharacterViewControllerProtocol: AnyObject {
    func showCharacters(_ data: CharactersDataViewModel)
}

final class SearchCharacterViewController: UIViewController, UISearchResultsUpdating {
    private let presenter: SearchCharacterPresenterProtocol
    private var searchBar: UISearchBar?

    private lazy var characterListView: CharacterListView = {
        let view = CharacterListView()
        view.tableView.dataSource = dataSource
        view.tableView.delegate = self
        return view
    }()

    private lazy var dataSource: SearchCharacterDataSource = {
        let dataSource = SearchCharacterDataSource()
        dataSource.delegate = self
        return dataSource
    }()

    init(presenter: SearchCharacterPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = characterListView
    }

    func updateSearchResults(for searchController: UISearchController) {
        dataSource.data = .empty
        characterListView.tableView.reloadData()

        guard let text = searchController.searchBar.text else { return }

        searchBar = searchController.searchBar
        presenter.fetchCharacter(name: text)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar?.endEditing(true)
    }
}

extension SearchCharacterViewController: SearchCharacterViewControllerProtocol {
    func showCharacters(_ data: CharactersDataViewModel) {
        dataSource.data = data // TODO: check if the presenter is responsible
        characterListView.tableView.reloadData()
    }
}

extension SearchCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = dataSource.data.characters[indexPath.row]
        print("go to \(character.name) detail")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.heightRow
    }
}

extension SearchCharacterViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath?, isFavorite: Bool) {

    }
}
