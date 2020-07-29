//
//  Extension.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Center
    func centerFromSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }

    func centerXAnchorFromSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }

    func centerYAnchorFromSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }

    func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        guard let constant = constant else {
            centerYAnchor.constraint(equalTo: anchor).isActive = true
            return
        }
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    // MARK: - Margins
    func fillSuperView() {
        if let view = superview {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
    }

    // MARK: - Height and Width
    func anchor(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
