//
//  DictionaryExtensionTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class DictionaryExtensionTests: XCTestCase {
    func testQueryItems() {
        let valueA = "testeA"
        let valueB = "testeB"

        let dic: [String: Any] = ["paramA": valueA, "paramB": valueB]

        let response = dic.queryItems
        let expectValues = [valueA, valueB]

        XCTAssertEqual(response.count, 2)
        XCTAssert(expectValues.contains(response[0].value!))
        XCTAssert(expectValues.contains(response[1].value!))
    }

    func testQueryItemsWhenTheyHaveAnIntValue() {
        let valueA = "testeA"

        let dic: [String: Any] = ["paramA": valueA, "paramB": 0]

        let response = dic.queryItems

        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response[0].value, valueA)
    }

    func testQueryItemsWhenThereAreNoItems() {
        let dic = [String: Any]()

        let response = dic.queryItems

        XCTAssertEqual(response.count, 0)
    }
}
