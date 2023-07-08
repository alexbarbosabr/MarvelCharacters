//
//  MarvelNavigationController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 24/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class MarvelNavigationController: UINavigationController {
    var statusBarStyle: UIStatusBarStyle = .default

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.tintColor = .systemRed

        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                         .foregroundColor: UIColor.systemRed]
        navigationBar.titleTextAttributes = attributes
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
}
