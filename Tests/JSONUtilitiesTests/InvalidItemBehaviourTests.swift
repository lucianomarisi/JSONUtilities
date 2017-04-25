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

  let key = "key"

  let dictionaryString = [
    "key": [
      "key1": "value1",
      "key2": 2
    ]
  ]

  let dictionaryConvertable = [
    "key": [
      "key1": "www.google.com",
      "key2": 2
    ]
  ]

  let dictionaryMockChild = [
    "key": [
      "key1": ["name": "john"],
      "key2": 2
    ]
  ]

  let arrayString = [
    "key": [
      "value1",
      2
    ]
  ]

  let arrayConvertable = [
    "key": [
      "www.google.com",
      2
    ]
  ]

  let arrayMockChild = [
    "key": [
      ["name": "john"],
      2
    ]
  ]

  // MARK: Dictionary InvalidItemBehaviour.fail

  func test_stringJSONRawTypeDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: String] = try dictionaryString.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: URL] = try dictionaryConvertable.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONObjectConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: "key2") {
      let _ : [String: MockSimpleChild] = try dictionaryMockChild.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  // MARK: Dictionary InvalidItemBehaviour.remove

  func test_stringJSONRawTypeDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    expectNoError {
      let decodedDictionary: [String: String] = try dictionaryString.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    expectNoError {
      let decodedDictionary: [String: URL] = try dictionaryConvertable.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  func test_stringJSONObjectConvertibleDictionary_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    expectNoError {
      let decodedDictionary: [String: MockSimpleChild] = try dictionaryMockChild.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  // MARK: Array InvalidItemBehaviour.fail

  func test_stringJSONRawTypeArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: key) {
      let _ : [String: String] = try arrayString.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONPrimitiveConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: key) {
      let _ : [URL] = try arrayConvertable.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  func test_stringJSONObjectConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    expectDecodingError(reason: .incorrectType, keyPath: key) {
      let _ : [MockSimpleChild] = try arrayMockChild.json(atKeyPath: key, invalidItemBehaviour: .fail)
    }
  }

  // MARK: Array InvalidItemBehaviour.remove

  func test_stringJSONRawTypeArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
   expectNoError {
      let decodedDictionary: [String] = try arrayString.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  func test_stringJSONPrimitiveConvertibleArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
   expectNoError {
      let decodedDictionary: [URL] = try arrayConvertable.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  func test_stringJSONObjectConvertibleArray_removesInvalidObjects_invalidItemBehaviourIsRemove() {
    expectNoError {
      let decodedDictionary: [MockSimpleChild] = try arrayMockChild.json(atKeyPath: key, invalidItemBehaviour: .remove)
      XCTAssert(decodedDictionary.count == 1)
    }
  }

  // MARK: Dictionary InvalidItemBehaviour.value

  func test_stringJSONRawTypeDictionary_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [String: String] = try dictionaryString.json(atKeyPath: key, invalidItemBehaviour: .value("default"))
      XCTAssert(decodedDictionary["key2"] == "default")
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionary_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [String: URL] = try dictionaryConvertable.json(atKeyPath: key, invalidItemBehaviour: .value(URL(string: "test.com")!))
      XCTAssert(decodedDictionary["key2"]?.absoluteString == "test.com")
    }
  }

  func test_stringJSONObjectConvertibleDictionaryy_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [String: MockSimpleChild] = try dictionaryMockChild.json(atKeyPath: key, invalidItemBehaviour: .value(MockSimpleChild(name: "default")))
      XCTAssert(decodedDictionary["key2"]?.name == "default")
    }
  }

  // MARK: Dictionary InvalidItemBehaviour.calculateValue

  func test_stringJSONRawTypeDictionary_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [String: String] = try dictionaryString.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({"\($0.value)"}))
      XCTAssert(decodedDictionary["key2"] == "2")
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionary_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [String: URL] = try dictionaryConvertable.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({URL(string: "\($0.value)")!}))
      XCTAssert(decodedDictionary["key2"]?.absoluteString == "2")
    }
  }

  func test_stringJSONObjectConvertibleDictionary_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [String: MockSimpleChild] = try dictionaryMockChild.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({MockSimpleChild(name: "\($0.value)") }))
      XCTAssert(decodedDictionary["key2"]?.name == "2")
    }
  }

  // MARK: Array InvalidItemBehaviour.value

  func test_stringJSONRawTypeArray_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [String] = try arrayString.json(atKeyPath: key, invalidItemBehaviour: .value("default"))
      XCTAssert(decodedDictionary.last == "default")
    }
  }

  func test_stringJSONPrimitiveConvertibleArray_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [URL] = try arrayConvertable.json(atKeyPath: key, invalidItemBehaviour: .value(URL(string: "test.com")!))
      XCTAssert(decodedDictionary.last?.absoluteString == "test.com")
    }
  }

  func test_stringJSONObjectConvertibleArray_setsValue_invalidItemBehaviourIsValue() {
    expectNoError {
      let decodedDictionary: [MockSimpleChild] = try arrayMockChild.json(atKeyPath: key, invalidItemBehaviour: .value(MockSimpleChild(name: "default")))
      XCTAssert(decodedDictionary.last?.name == "default")
    }
  }

  // MARK: Array InvalidItemBehaviour.calculateValue

  func test_stringJSONRawTypeArray_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [String] = try arrayString.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({"\($0.value)"}))
      XCTAssert(decodedDictionary.last == "2")
    }
  }

  func test_stringJSONPrimitiveConvertibleArray_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [URL] = try arrayConvertable.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({URL(string: "\($0.value)")!}))
      XCTAssert(decodedDictionary.last?.absoluteString == "2")
    }
  }

  func test_stringJSONObjectConvertibleArray_setsValue_invalidItemBehaviourIsCalculateValue() {
    expectNoError {
      let decodedDictionary: [MockSimpleChild] = try arrayMockChild.json(atKeyPath: key, invalidItemBehaviour: .calculateValue({MockSimpleChild(name: "\($0.value)") }))
      XCTAssert(decodedDictionary.last?.name == "2")
    }
  }

}
