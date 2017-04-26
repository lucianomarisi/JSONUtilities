//
//  InvalidItemBehaviourTests.swift
//  JSONUtilities
//
//  Created by Yonas Kolb on 21/4/17.
//  Copyright © 2017 Luciano Marisi. All rights reserved.
//

import XCTest
@testable import JSONUtilities

private let randomKey = "aaaaaaa"

class InvalidItemBehaviourTests: XCTestCase {

  // MARK: Dictionary InvalidItemBehaviour.fail

  func test_stringJSONRawTypeDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": "value1",
        "key2": 2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": "www.google.com",
        "key2": 2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONObjectConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": ["name": "john"],
        "key2": 2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  // MARK: Dictionary InvalidItemBehaviour.remove

  func test_stringJSONRawTypeDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        "key1": "value1",
        "key2": 2
      ]
    ]
    do {
      let decodedDictionary: [String: String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        "key1": "www.google.com",
        "key2": 2
      ]
    ]
    do {
      let decodedDictionary: [String: URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

  func test_stringJSONObjectConvertibleDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        "key1": ["name": "john"],
        "key2": 2
      ]
    ]
    do {
      let decodedDictionary: [String: MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

  // MARK: Array InvalidItemBehaviour.fail

  func test_stringJSONRawTypeArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "value1",
        2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key") {
      let _ : [String: String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONPrimitiveConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "www.google.com",
        2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key") {
      let _ : [URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONObjectConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        ["name": "john"],
        2
      ]
    ]

    expectDecodingError(reason: .incorrectType, keyPath: "key") {
      let _ : [MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .fail)
    }
  }

  // MARK: Array InvalidItemBehaviour.remove

  func test_stringJSONRawTypeArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        "value1",
        2
      ]
    ]
    do {
      let decodedDictionary: [String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

  func test_stringJSONPrimitiveConvertibleArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        "www.google.com",
        2
      ]
    ]
    do {
      let decodedDictionary: [URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

  func test_stringJSONObjectConvertibleArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    let dictionary = [
      "key": [
        ["name": "john"],
        2
      ]
    ]
    do {
      let decodedDictionary: [MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    } catch {
      XCTFail("Should not throw error")
    }
  }

}
