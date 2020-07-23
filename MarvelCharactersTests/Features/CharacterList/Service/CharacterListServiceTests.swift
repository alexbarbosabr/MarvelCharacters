//
//  CharacterListServiceTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterListServiceTests: XCTestCase {
    private var sut: CharacterListService!
    private var spyService: ServiceSpy!

    override func setUp() {
        spyService = ServiceSpy()
        sut = CharacterListService(service: spyService)
    }

    func testRequest() {
        let exp = expectation(description: "Request")

        sut.request(offset: 0, limit: nil, startName: nil) { _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
        XCTAssert(spyService.hasCalledRequestWithEndPoint)
    }

    func testCancelRequest() {
        sut.cancelRequest()

        XCTAssert(spyService.hasCalledCancelRequest)
    }
}
