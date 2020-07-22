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

    private let refreshImageView: UIImageView = {
        let image = UIImage(systemName: AlertIcon.refresh.rawValue)
        let view = UIImageView()
        view.image = image
        view.tintColor = .secondaryLabel
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = L10n.CharacterList.Error.tryAgain
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: 5, left: 16, bottom: 5, right: 16))
    }
}

extension ErrorCell: CodeView {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(refreshImageView)
        stackView.addArrangedSubview(errorLabel)
        contentView.addSubview(stackView)
    }

    func makeContraints() {
        stackView.centerFromSuperView()
    }

    func makeAddicionalConfiguration() {
        contentView.backgroundColor = .customSecondaryBackground
        contentView.layer.cornerRadius = 3
        contentView.layer.borderWidth = 0
        contentView.clipsToBounds = true

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
        backgroundColor = .clear
    }
}
