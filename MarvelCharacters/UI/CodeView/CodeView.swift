//
//  CodeView.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func makeContraints()
    func makeAddicionalConfiguration()
    func makeView()
}

extension CodeView {
    func makeView() {
        buildViewHierarchy()
        makeContraints()
        makeAddicionalConfiguration()
    }

    func makeAddicionalConfiguration() {}
}
