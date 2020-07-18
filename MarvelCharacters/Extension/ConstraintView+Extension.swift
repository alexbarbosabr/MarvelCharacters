//
//  Extension.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

extension UIView {
    func centerFromSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }

    func fillSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    }
}
