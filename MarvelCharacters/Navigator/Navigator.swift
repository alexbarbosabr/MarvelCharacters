//
//  Navigator.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 24/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class Navigator {
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    private var characterListViewController: CharacterListViewController!

    init(window: UIWindow?) {
        self.window = window
    }

    func startRootController() {
        let presenter = CharacterListPresenter()
        let searchPresenter = SearchCharacterPresenter()

        let searchcontroller = SearchCharacterViewController(presenter: searchPresenter)
        searchPresenter.view = searchcontroller

        let controller = CharacterListViewController(presenter: presenter,
                                                     searchViewController: searchcontroller,
                                                     navigatorListener: self)
        presenter.view = controller

        navigationController = MarvelNavigationController(rootViewController: controller)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension Navigator: CharacterListNavigatorListener {
    func goToDetail(character: Character) {
        let presenter = CharacterDetailPresenter()
        let controller = CharacterDetailViewController(presenter: presenter, character: character)
        navigationController?.pushViewController(controller, animated: true)
    }
}
