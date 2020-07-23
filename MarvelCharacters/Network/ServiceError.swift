//
//  ServiceError.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

enum ServiceError: Int, Error {
    case unexpected
    case noInternet = -1009
    case cancelRequest = -999
}
