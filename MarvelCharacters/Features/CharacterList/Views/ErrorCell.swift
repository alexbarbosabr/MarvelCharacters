//
//  ErrorCell.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 19/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class ErrorCell: UITableViewCell {
    static let identifier = String(describing: ErrorCell.self)

    private let errorLabel =  UIActivityIndicatorView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textAlignment = .center
        textLabel?.numberOfLines = 2
        textLabel?.textColor = .secondaryLabel
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        textLabel?.text = L10n.CharacterList.Error.tryAgain

        contentView.backgroundColor = .customSecondaryBackground
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 0
        contentView.clipsToBounds = true

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 5, left: 16, bottom: 5, right: 16))

        if let frame = textLabel?.frame.inset(by: .init(top: 0, left: -16, bottom: 0, right: 0)) {
            textLabel?.frame = frame
        }
    }
}
