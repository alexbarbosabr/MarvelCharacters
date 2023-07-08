//
//  MessageView.swift
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

final class MessageView: UIView {
    weak var delegate: AlertViewDelegate?

    var message: String? {
        get { return messageLabel.text }
        set { messageLabel.text = newValue }
    }

    var showTryAgain: Bool {
        get { return tryAgainButton.isHidden }
        set { tryAgainButton.isHidden = !newValue }
    }

    private var iconImageView: UIImageView = {
        let view = UIImageView(image: Icon.generic.image)
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

    private lazy var tryAgainButton: UIButton = {
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
        iconImageView.image = icon.image
    }
}

extension MessageView: CodeView {
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
