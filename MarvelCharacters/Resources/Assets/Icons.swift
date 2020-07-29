//
//  Icons.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 29/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

enum Icon: String {
    case generic = "exclamationmark.triangle"
    case search = "magnifyingglass"
    case noInternet = "wifi.slash"
    case refresh = "arrow.clockwise"
    case emptyList = "rectangle.stack.person.crop"
    case back = "chevron.left"
    case heart = "heart"
    case heartFill = "heart.fill"
    case suitHeart = "suit.heart"
    case suitHeartFill = "suit.heart.fill"

    var image: UIImage {
        UIImage(systemName: rawValue)!
    }
}
