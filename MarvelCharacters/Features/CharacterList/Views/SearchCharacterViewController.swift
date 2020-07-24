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
    func showEmptyCharacters()
    func showError(withIcon icon: Icon, message: String)
    func showLoading()
    func hideLoading()
}

final class SearchCharacterViewController: UIViewController, UISearchResultsUpdating {
    private let presenter: SearchCharacterPresenterProtocol
    private let loadingView = LoadingView()
    private let alertView = AlertView()
    private var searchBar: UISearchBar?
    weak var delegate: CharacterListViewDelegate?

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
        makeView()
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

    func showEmptyCharacters() {
        alertView.isHidden = false
        alertView.setIcon(.search)
        alertView.message = L10n.Message.notfound
    }

    func showError(withIcon icon: Icon, message: String) {
        alertView.isHidden = false
        alertView.setIcon(icon)
        alertView.message = message
    }

    func showLoading() {
        alertView.isHidden = true
        loadingView.isHidden = false
        loadingView.start()
    }

    func hideLoading() {
        loadingView.isHidden = true
        loadingView.stop()
    }
}

extension SearchCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = dataSource.data.characters[indexPath.row]
        delegate?.goToDetail(character: character)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.heightRow
    }
}

extension SearchCharacterViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath?, isFavorite: Bool) {

    }
}

extension SearchCharacterViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(characterListView)
        view.addSubview(loadingView)
        view.addSubview(alertView)
    }

    func makeContraints() {
        characterListView.fillSuperView()

        loadingView.anchor(height: 120)
        loadingView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           leading: view.leadingAnchor,
                           trailing: view.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 0))

        alertView.anchor(height: 200)
        alertView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}
