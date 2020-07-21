//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

protocol CharacterListViewControllerProtocol: AnyObject {
    func showCharacters(_ data: CharactersDataViewModel)
    func error(didShowLoading: Bool)
    func loading()
}

final class CharacterListViewController: UIViewController {
    private let presenter: CharacterListPresenterProtocol
    private let searchViewController: SearchCharacterViewController

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

    init(presenter: CharacterListPresenterProtocol, searchViewController: SearchCharacterViewController) {
        self.presenter = presenter
        self.searchViewController = searchViewController
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

        presenter.fetchCharacters(showLoading: true)
    }

    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: searchViewController)
        search.searchResultsUpdater = searchViewController
        search.searchBar.tintColor = .systemRed
        search.searchBar.placeholder = L10n.CharacterList.SearchBar.placeholder
        search.obscuresBackgroundDuringPresentation = false
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
        presenter.fetchCharacters(showLoading: false)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
          navigationController?.setNavigationBarHidden(true, animated: true)

       } else {
          navigationController?.setNavigationBarHidden(false, animated: true)
       }
    }
}

extension CharacterListViewController: CharacterListViewControllerProtocol {
    func showCharacters(_ data: CharactersDataViewModel) {
        dataSource.data = data
        characterListView.tableView.reloadData()

        view = characterListView
    }

    func error(didShowLoading: Bool) {
        print("show error")

        if didShowLoading {

        } else {
            dataSource.showError = true
            characterListView.tableView.reloadData()
        }
    }

    func loading() {
        let loading = LoadingView()
        view = loading
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

        let character = dataSource.data.characters[indexPath.row]
        print("go to \(character.name) detail")
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
    func setFavorite(index: IndexPath?, isFavorite: Bool) {
        if let index = index?.row {
            // TODO: check if the presenter is responsible
            dataSource.data.characters[index].setFavorite(isFavorite)
        }
    }
}
