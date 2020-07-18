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

        service.request { (result) in
            switch result {
            case .success(let charactersData):
                for character in charactersData.data.results {
                    print(character.name)
                    print(character.description)
                    print(character.thumbnail.getImageUrl() ?? String())
                    print("---")
                }
            case .failure(let error):
                let error: NSError = error as NSError
                print("Error code \(error.code)")
            }
        }
    }
}
