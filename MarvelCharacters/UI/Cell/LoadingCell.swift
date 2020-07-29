//
//  LoadingCell.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 19/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class LoadingCell: UITableViewCell {
    static let identifier = String(describing: LoadingCell.self)

    private let loadingIndicatorView =  UIActivityIndicatorView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessibilityIdentifier = "LoadingCell"
        makeView()
        isUserInteractionEnabled = false
    }

    func startLoading() {
        loadingIndicatorView.startAnimating()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(loadingIndicatorView)
    }

    func makeContraints() {
        loadingIndicatorView.centerFromSuperView()
    }

    func makeAddicionalConfiguration() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
