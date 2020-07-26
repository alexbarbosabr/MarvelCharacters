//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func showCharacters(_ data: CharactersDataViewModel)
    func showEmptyList(withIcon icon: Icon, message: String)
    func showErrorOnScreen(withIcon icon: Icon, message: String)
    func showLoadingOnScreen()
    func showErrorOnTableView()
    func updateCell(index: IndexPath)
    func refreshTable(_ data: CharactersDataViewModel)
}

protocol CharacterListViewDelegate: AnyObject {
    func goToDetail(character: Character)
    func reloadTable()
}

protocol CharacterListNavigatorListener {
    func goToDetail(character: Character)
}

final class CharacterListViewController: UIViewController {
    private let presenter: CharacterListPresenterProtocol
    private let searchViewController: SearchCharacterViewController
    private let navigatorListener: CharacterListNavigatorListener
    private var updateWhenBackFromDetail: Bool = false

    private lazy var characterListView: CharacterListView = {
        let view = CharacterListView()
        view.tableView.dataSource = dataSource
        view.tableView.delegate = self
        view.tableView.prefetchDataSource = self
        return view
    }()

    private lazy var dataSource: CharacterListDataSource = {
        let dataSource = CharacterListDataSource()
        dataSource.delegate = self
        return dataSource
    }()

    init(presenter: CharacterListPresenterProtocol,
         searchViewController: SearchCharacterViewController,
         navigatorListener: CharacterListNavigatorListener) {
        self.presenter = presenter
        self.searchViewController = searchViewController
        self.navigatorListener = navigatorListener
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.CharacterList.title

        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                         .foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.titleTextAttributes = attributes

        setupSearchBar()

        presenter.fetchCharacters(showScreenLoading: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if updateWhenBackFromDetail {
            updateWhenBackFromDetail = false
            presenter.updateCharactersWhenSetFavoriteInOtherContext()
            searchViewController.updateCharactersWhenSetFavoriteInOtherContext()
        }
    }

    private func setupSearchBar() {
        searchViewController.delegate = self
        let search = UISearchController(searchResultsController: searchViewController)
        search.searchResultsUpdater = searchViewController
        search.searchBar.tintColor = .systemRed
        search.searchBar.placeholder = L10n.CharacterList.SearchBar.placeholder
        search.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = search
    }

    static func isLoadingCell(for indexPath: IndexPath, currentCount: Int) -> Bool {
        return indexPath.row >= currentCount
    }

    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = characterListView.tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }

    private func fetchCharacters(indexPath: IndexPath? = nil) {
        if let indexPath = indexPath {
            characterListView.tableView.beginUpdates()
            characterListView.tableView.reloadRows(at: [indexPath], with: .none)
            characterListView.tableView.endUpdates()
        }
        presenter.fetchCharacters(showScreenLoading: false)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension CharacterListViewController: CharacterListViewProtocol {
    func showCharacters(_ data: CharactersDataViewModel) {
        dataSource.data = data
        characterListView.tableView.reloadData()

        view = characterListView
    }

    func showEmptyList(withIcon icon: Icon, message: String) {
        let alert = AlertView()
        alert.setIcon(icon)
        alert.message = message
        view = alert
    }

    func showErrorOnScreen(withIcon icon: Icon, message: String) {
        let alert = AlertView()
        alert.setIcon(icon)
        alert.message = message
        alert.showTryAgain = true
        alert.delegate = self
        view = alert
    }

    func showErrorOnTableView() {
        dataSource.showError = true
        characterListView.tableView.reloadData()
    }

    func showLoadingOnScreen() {
        let loading = LoadingView()
        view = loading
    }

    func updateCell(index: IndexPath) {
        characterListView.tableView.beginUpdates()
        characterListView.tableView.reloadRows(at: [index], with: .none)
        characterListView.tableView.endUpdates()
    }

    func refreshTable(_ data: CharactersDataViewModel) {
        dataSource.data = data
        characterListView.tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.heightRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.data.characters.count && dataSource.showError {
            dataSource.showError = false
            fetchCharacters(indexPath: indexPath)
            return
        }

        updateWhenBackFromDetail = true
        let character = dataSource.data.characters[indexPath.row]
        navigatorListener.goToDetail(character: character)
    }
}

extension CharacterListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let currentCount = dataSource.data.characters.count

        if indexPaths.contains(where: { index -> Bool in
            CharacterListViewController.isLoadingCell(for: index, currentCount: currentCount)
        }) {
            if !dataSource.showError {
                fetchCharacters()
            }
        }
    }
}

extension CharacterListViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath, isFavorite: Bool, imageData: Data?) {
        presenter.setFavorite(indexPath: index, isFavorite: isFavorite, imageData: imageData)
    }
}

extension CharacterListViewController: AlertViewDelegate {
    func tryAgain() {
        presenter.fetchCharacters(showScreenLoading: true)
    }
}

extension CharacterListViewController: CharacterListViewDelegate {
    func goToDetail(character: Character) {
        updateWhenBackFromDetail = true
        navigatorListener.goToDetail(character: character)
    }

    func reloadTable() {
        presenter.updateCharactersWhenSetFavoriteInOtherContext()
    }
}
