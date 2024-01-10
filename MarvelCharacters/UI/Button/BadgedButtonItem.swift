//
//  BadgedButtonItem.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class BadgedButtonItem: UIBarButtonItem {
    private lazy var badgeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 40))
        button.adjustsImageWhenHighlighted = false
        button.setImage(Icon.heart.image, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private let badgeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 26, y: 10, width: 15, height: 15))
        label.backgroundColor = .darkGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 7
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.isHidden = true
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var badgeValue: Int? {
        didSet {
            if let value = badgeValue, value > 0 {
                var valueLabel = String(value)
                if value > 99 {
                    valueLabel = "99+"
                    badgeLabel.frame = CGRect(x: 26, y: 6, width: 24, height: 15)
                } else {
                    badgeLabel.frame = CGRect(x: 26, y: 6, width: 15, height: 15)
                }

                badgeLabel.isHidden = false
                badgeLabel.text = valueLabel
            } else {
                badgeLabel.isHidden = true
            }
        }
    }

    var tapAction: (() -> Void)?

    override init() {
        super.init()
        self.badgeButton.addSubview(badgeLabel)
        self.customView = badgeButton
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func buttonPressed() {
        if let action = tapAction {
            action()
        }
    }

    public func setBadge(with value: Int) {
        self.badgeValue = value
    }
}
