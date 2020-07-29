//
//  ServiceSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class ServiceSpy: ServiceProtocol {
    private (set) var hasCalledRequestWithEndPoint = false
    private (set) var hasCalledRequestUrl = false
    private (set) var hasCalledCancelRequest = false

    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        hasCalledRequestWithEndPoint = true

        completion(.failure(ServiceError.unexpected))
    }

    func request(url: URL, httpMethod: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        hasCalledRequestUrl = true
    }

    func cancelRequest() {
        hasCalledCancelRequest = true
    }
}
