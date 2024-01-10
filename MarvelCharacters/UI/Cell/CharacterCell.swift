//
//  CharacterCell.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit
import Kingfisher

protocol CharacterCellDelegate: AnyObject {
    func tapFavoriteButton(index: IndexPath, isFavorite: Bool, imageData: Data?)
}

final class CharacterCell: UITableViewCell {
    static let identifier = String(describing: CharacterCell.self)
    static let heightRow: CGFloat = 122
    private let topMargin: CGFloat = 6
    private var indexPath: IndexPath?

    weak var delegate: CharacterCellDelegate?

    let characterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = ContentMode.scaleToFill
        return view
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.suitHeartFill.image, for: .selected)
        button.setImage(Icon.suitHeart.image, for: .normal)
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .init(top: topMargin, left: 16, bottom: topMargin, right: 16))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(character: Character, indexPath: IndexPath?, imageData: Data? = nil) {
        self.indexPath = indexPath
        setupAccessibility(character: character, indexPath: indexPath)

        favoriteButton.isSelected = character.favorite ?? false
        setFavoriteButtonTintColor()

        if let data = imageData {
            characterImageView.image = UIImage(data: data)
        } else {
            let placeholder = UIImage(named: "placeholder")
            let url = character.thumbnail.getImageUrl()
            characterImageView.kf.setImage(with: url, placeholder: placeholder)
        }

        nameLabel.text = character.name
        addDescription(character: character)
    }

    private func setupAccessibility(character: Character, indexPath: IndexPath?) {
        let row = indexPath?.row ?? 0
        let cell = "Cell"
        let button = "FavoriteButton"

        accessibilityLabel = "\(character.name) \(cell)"
        accessibilityIdentifier = "\(cell)\(row)"

        favoriteButton.accessibilityLabel = "\(character.name) \(button)"
        favoriteButton.accessibilityIdentifier = "\(button)\(row)"
    }

    @objc
    private func tapFavoriteButton() {
        if let index = indexPath {
            delegate?.tapFavoriteButton(index: index,
                                        isFavorite: !favoriteButton.isSelected,
                                        imageData: imageView?.image?.pngData())
        }
    }

    private func setFavoriteButtonTintColor() {
        favoriteButton.tintColor = favoriteButton.isSelected ? .systemRed : .systemGray3
    }

    private func addDescription(character: Character) {
        descLabel.removeFromSuperview()
        if character.description != String() {
            descLabel.text = character.description
            stackView.addArrangedSubview(descLabel)
        }
    }
}

extension CharacterCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(characterImageView)
        stackView.addArrangedSubview(nameLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(favoriteButton)
    }

    func makeContraints() {
        characterImageView.anchor(width: CharacterCell.heightRow - topMargin * 2)
        characterImageView.anchor(top: contentView.topAnchor,
                                  leading: contentView.leadingAnchor,
                                  bottom: contentView.bottomAnchor)

        stackView.centerYAnchorFromSuperView()
        stackView.anchor(leading: characterImageView.trailingAnchor,
                         trailing: favoriteButton.leadingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 0, right: -2))

        favoriteButton.anchor(trailing: contentView.trailingAnchor)
        favoriteButton.centerYAnchorFromSuperView()
        favoriteButton.anchor(height: 44, width: 44)
    }

    func makeAddicionalConfiguration() {
        contentView.backgroundColor = .secondaryBackground
        contentView.layer.cornerRadius = 3
        contentView.layer.borderWidth = 0
        contentView.clipsToBounds = true

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
        backgroundColor = .clear
    }
}
