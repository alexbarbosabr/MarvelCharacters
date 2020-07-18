//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class CharacterListViewController: UIViewController {

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
        let service = CharacterListService()
        service.request {
            print("has called service")
        }
    }
}
