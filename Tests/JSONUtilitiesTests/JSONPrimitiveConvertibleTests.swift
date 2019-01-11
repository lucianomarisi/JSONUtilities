//
//  JSONPrimitiveConvertibleTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 13/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import XCTest
@testable import JSONUtilities

private let invalidKey = "invalidKey"

class JSONPrimitiveConvertibleTests: XCTestCase {

  func testDecodedAndTransformNSURL() {
    let urlString = "www.google.com"
    let expectedURL = URL(string: urlString)
    let jsonDictionary = [
      "url": urlString,
      "invalid_url": "±"
    ]

    guard let mandatoryTransformedURL: URL = try? jsonDictionary.json(atKeyPath: "url") else {
      XCTFail(#function)
      return
    }
    XCTAssertEqual(expectedURL, mandatoryTransformedURL)

    let optionalTransformedURL: URL? = jsonDictionary.json(atKeyPath: "url")
    XCTAssertEqual(expectedURL, optionalTransformedURL)

    expectDecodingError(reason: .conversionFailure, keyPath: "invalid_url") {
      let _ : URL = try jsonDictionary.json(atKeyPath: "invalid_url")
    }
  }

  func testDecodedAndTransformNSURL_missingKey() {
    let jsonDictionary = ["url": "url"]

    expectDecodingError(reason: .keyNotFound, keyPath: invalidKey) {
        let _ : URL = try jsonDictionary.json(atKeyPath: invalidKey)
    }

    let urlFromMissingKey: URL? = jsonDictionary.json(atKeyPath: invalidKey)
    XCTAssertNil(urlFromMissingKey)
  }

  func testJSONPrimitiveConvertibleArray() {
    let expectedURLStrings = ["www.google.com", "www.apple.com"]
    let expectedURLs = expectedURLStrings.compactMap { URL(string: $0) }
    let jsonDictionary = ["urls": expectedURLStrings]
    let decodedURLs: [URL] = try! jsonDictionary.json(atKeyPath: "urls")
    XCTAssertEqual(decodedURLs, expectedURLs)

    expectDecodingError(reason: .keyNotFound, keyPath: invalidKey) {
      let _ : URL = try jsonDictionary.json(atKeyPath: invalidKey)
    }

    let decodedOptionalURLs: [URL]? = jsonDictionary.json(atKeyPath: "urls")
    XCTAssertEqual(decodedOptionalURLs!, expectedURLs)

    let decodedMissingURLs: [URL]? = jsonDictionary.json(atKeyPath: invalidKey)
    XCTAssertNil(decodedMissingURLs)
  }

  func testJSONPrimitiveConvertibleArray_failsOnNonTransformable() {
    let expectedURLStrings = ["www.google.com", "±"]
    let jsonDictionary = ["urls": expectedURLStrings]

    expectDecodingError(reason: .conversionFailure, keyPath: "urls") {
      let _ : [URL] = try jsonDictionary.json(atKeyPath: "urls", invalidItemBehaviour: .fail)
    }
  }

}
