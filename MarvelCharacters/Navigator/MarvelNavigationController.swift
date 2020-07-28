//
//  MarvelNavigationController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 24/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class MarvelNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.tintColor = .systemRed
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
