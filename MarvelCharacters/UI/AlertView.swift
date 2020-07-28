//
//  AlertView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 21/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit
import Foundation

protocol AlertViewDelegate: AnyObject {
    func tryAgain()
}

enum Icon: String {
    case generic = "exclamationmark.triangle"
    case search = "magnifyingglass"
    case noInternet = "wifi.slash"
    case refresh = "arrow.clockwise"
    case emptyList = "rectangle.stack.person.crop"
    case back = "chevron.left"
    case heart = "heart"
    case heartFill = "heart.fill"

    var image: UIImage {
        UIImage(systemName: rawValue)!
    }
}

final class AlertView: UIView {
    weak var delegate: AlertViewDelegate?

    var message: String? {
        set { messageLabel.text = newValue }
        get { return messageLabel.text }
    }

    var showTryAgain: Bool {
        set { tryAgainButton.isHidden = !newValue }
        get { return tryAgainButton.isHidden }
    }

    private var iconImageView: UIImageView = {
        let image = UIImage(systemName: "exclamationmark.triangle")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.tintColor = .secondaryLabel
        return view
    }()

    private var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()

    private let tryAgainButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle(L10n.tryAgain, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        let padding: CGFloat = 16
        button.contentEdgeInsets.left = padding
        button.contentEdgeInsets.right = padding
        button.isHidden = true
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        makeView()
    }

    @objc private func tryAgain() {
        delegate?.tryAgain()
    }

    func setIcon(_ icon: Icon) {
        iconImageView.image = UIImage(systemName: icon.rawValue)
    }
}

extension AlertView: CodeView {
    func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(messageLabel)
        addSubview(tryAgainButton)
    }

    func makeContraints() {

        iconImageView.anchor(height: 40, width: 40)
        iconImageView.anchor(bottom: messageLabel.topAnchor,
                             padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        iconImageView.centerXAnchorFromSuperView()

        messageLabel.centerYAnchorFromSuperView()
        messageLabel.anchor(leading: leadingAnchor, trailing: trailingAnchor,
                            padding: .init(top: 0, left: 16, bottom: 0, right: 16))

        tryAgainButton.anchor(height: 44)
        tryAgainButton.centerXAnchorFromSuperView()
        tryAgainButton.anchor(top: messageLabel.bottomAnchor,
                              padding: .init(top: 20, left: 0, bottom: 0, right: 16))
    }

    func makeAddicionalConfiguration() {
        backgroundColor = .primaryBackground
    }
}
