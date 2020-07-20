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
        title = L10n.CharacterList.title

        presenter.fetchCharacters(showLoading: true)
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
        dataSource.showError = false

        if let indexPath = indexPath {
            characterListView.tableView.beginUpdates()
            characterListView.tableView.reloadRows(at: [indexPath], with: .none)
            characterListView.tableView.endUpdates()
        }
        presenter.fetchCharacters(showLoading: false)
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
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.data.characters.count && dataSource.showError {
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
            fetchCharacters()
        }
    }
}

extension CharacterListViewController: CharacterCellDelegate {
    func setFavorite(index: IndexPath?, isFavorite: Bool) {
        if let index = index?.row {
            dataSource.data.characters[index].setFavorite(isFavorite)
        }
    }
}
