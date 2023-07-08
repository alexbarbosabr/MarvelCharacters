//
//  UINavigationController+Extension.swift
//  MarvelCharacters
//
//  Created by Alex on 30/06/22.
//  Copyright © 2022 Alex Barbosa. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setStatusBarStyle(_ style: UIStatusBarStyle = .default) {
        let navigation = self as? MarvelNavigationController
        navigation?.statusBarStyle = style
    }
}
