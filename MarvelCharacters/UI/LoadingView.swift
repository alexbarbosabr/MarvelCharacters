//
//  LoadingView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit
import Foundation

final class LoadingView: UIView {
    private let loading = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        makeView()
        loading.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: CodeView {
    func buildViewHierarchy() {
        addSubview(loading)
    }

    func makeContraints() {
        loading.centerFromSuperView()
    }

    func makeAddicionalConfiguration() {
        backgroundColor = .secondarySystemBackground
    }
}