//
//  CharacterDetailView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit
import Kingfisher

protocol CharacterDetailViewDelegate: AnyObject {
    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?)
}

final class CharacterDetailView: UIView {
    weak var delegate: CharacterDetailViewDelegate?

    private let favoriteButtonSize: CGFloat = 44

    private let scrollView = UIScrollView()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .redraw
        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.suitHeartFill.image, for: .selected)
        button.setImage(Icon.suitHeart.image, for: .normal)
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.backgroundColor = .tertiarySystemBackground
        button.layer.cornerRadius = favoriteButtonSize / 2
        button.layer.borderWidth = 0
        return button
    }()

    private let dataView = UIView()
    private let dataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        return label
    }()

    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let character: Character

    init(frame: CGRect = .zero, character: Character) {
        self.character = character
        super.init(frame: frame)
        makeView()

        let placeholder = UIImage(named: "placeholder")
        let url = character.thumbnail.getImageUrl()
        imageView.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil)

        favoriteButton.isSelected = character.favorite ?? false
        setFavoriteButtonTintColor()

        titleLabel.text = character.name
        descriptionLabel.text = character.description
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func tapFavoriteButton() {
        favoriteButton.isSelected.toggle()
        setFavoriteButtonTintColor()
        delegate?.setFavorite(character: character,
                              isFavorite: favoriteButton.isSelected,
                              imageData: imageView.image?.pngData())
    }

    @objc
    private func setFavoriteButtonTintColor() {
        favoriteButton.tintColor = favoriteButton.isSelected ? .systemRed : .systemGray3
    }
}

extension CharacterDetailView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        coverView.addSubview(imageView)
        coverView.addSubview(favoriteButton)
        stackView.addArrangedSubview(coverView)
        dataStackView.addArrangedSubview(titleLabel)

        if character.description != String() {
            dataStackView.addArrangedSubview(aboutLabel)
            dataStackView.addArrangedSubview(descriptionLabel)
        }

        dataView.addSubview(dataStackView)
        stackView.addArrangedSubview(dataView)
    }

    func makeContraints() {
        scrollView.fillSuperView()
        stackView.fillSuperView()
        stackView.anchor(width: UIScreen.main.bounds.width)

        imageView.anchor(top: coverView.topAnchor,
                         leading: coverView.leadingAnchor,
                         bottom: coverView.bottomAnchor,
                         trailing: coverView.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 2, right: 0))

        let favoriteBottom = favoriteButtonSize / 2
        favoriteButton.anchor(bottom: coverView.bottomAnchor,
                              trailing: coverView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: -favoriteBottom, right: 20))

        favoriteButton.anchor(height: favoriteButtonSize, width: favoriteButtonSize)

        imageView.anchor(height: UIScreen.main.bounds.width)

        dataStackView.anchor(top: dataView.topAnchor,
                             leading: dataView.leadingAnchor,
                             bottom: dataView.bottomAnchor,
                             trailing: dataView.trailingAnchor,
                             padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }

    func makeAddicionalConfiguration() {
        backgroundColor = .primaryBackground
    }
}
