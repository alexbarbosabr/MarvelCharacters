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
    func updateCell(index: IndexPath)
}

final class SearchCharacterViewController: UIViewController, UISearchResultsUpdating {
    private let presenter: SearchCharacterPresenterProtocol
    private let loadingView = LoadingView()
    private let alertView = AlertView()
    private var searchBar: UISearchBar?
    private var updateWhenBackFromDetail: Bool = false
    private var currentSearchText = String()
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
        guard let text = searchController.searchBar.text, currentSearchText != text else { return }
        currentSearchText = text

        dataSource.data = .empty
        characterListView.tableView.reloadData()

        searchBar = searchController.searchBar
        presenter.fetchCharacter(name: text)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar?.endEditing(true)
    }

    func updateCharactersWhenSetFavoriteInOtherContext() {
        presenter.updateCharactersWhenSetFavoriteInOtherContext()
    }
}

extension SearchCharacterViewController: SearchCharacterViewControllerProtocol {
    func showCharacters(_ data: CharactersDataViewModel) {
        dataSource.data = data
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

    func updateCell(index: IndexPath) {
        characterListView.tableView.beginUpdates()
        characterListView.tableView.reloadRows(at: [index], with: .none)
        characterListView.tableView.endUpdates()
        delegate?.reloadTable()
    }
}

extension SearchCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateWhenBackFromDetail = true
        searchBar?.searchTextField.endEditing(true)

        let character = dataSource.data.characters[indexPath.row]
        delegate?.goToDetail(character: character)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.heightRow
    }
}

extension SearchCharacterViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath, isFavorite: Bool, imageData: Data?) {
        presenter.setFavorite(indexPath: index, isFavorite: isFavorite, imageData: imageData)
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
