//
//  EndPoint.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var apiPath: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "gateway.marvel.com" }
    var port: Int { 443 }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem] { parameters.queryItems }
}
