//
//  CharactersEndpointTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharactersEndpointTests: XCTestCase {
    func testEndpointWithNilParameters() {
        let expectLimit = "30"
        let expectOffset = "0"
        let apiPath = "/v1/public/characters"

        let endpoint = CharactersEndpoint(offset: nil, limit: nil, startName: nil)
        let limit = endpoint.parameters["limit"] as? String
        let offset = endpoint.parameters["offset"] as? String

        XCTAssertEqual(limit, expectLimit)
        XCTAssertEqual(offset, expectOffset)
        XCTAssertEqual(endpoint.apiPath, apiPath)
    }

    func testEndpointWithAllParameters() {
        let expectLimit = "100"
        let expectOffset = "10"
        let expectStartName = "Captain"

        let endpoint = CharactersEndpoint(offset: 10, limit: 100, startName: expectStartName)
        let limit = endpoint.parameters["limit"] as? String
        let offset = endpoint.parameters["offset"] as? String
        let nameStart = endpoint.parameters["nameStartsWith"] as? String

        XCTAssertEqual(limit, expectLimit)
        XCTAssertEqual(offset, expectOffset)
        XCTAssertEqual(nameStart, expectStartName)
    }

    func testEndpointWithOnlyTheStartNameParameter() {
        let expectLimit = "30"
        let expectOffset = "0"
        let expectStartName = "Captain"

        let endpoint = CharactersEndpoint(offset: nil, limit: nil, startName: expectStartName)
        let limit = endpoint.parameters["limit"] as? String
        let offset = endpoint.parameters["offset"] as? String
        let nameStart = endpoint.parameters["nameStartsWith"] as? String

        XCTAssertEqual(limit, expectLimit)
        XCTAssertEqual(offset, expectOffset)
        XCTAssertEqual(nameStart, expectStartName)
    }
}
