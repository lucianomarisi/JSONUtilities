//
//  InlineDecodingTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import XCTest
@testable import JSONUtilities

private let randomKey = "aaaaaaa"

class InlineDecodingTests: XCTestCase {

  func testDecodingOfJSONRawTypes() {
    let expectedInt: Int = 1
    expectDecodeType(expectedInt)

    let expectedFloat: Float = 2.2
    expectDecodeType(expectedFloat)

    let expectedDouble: Double = 2.2
    expectDecodeType(expectedDouble)

    let expectedString: String = "something"
    expectDecodeType(expectedString)

    let expectedBool: Bool = true
    expectDecodeType(expectedBool)
  }

  func testDecodingOfJSONDictionary() {

    let expectedValue: JSONDictionary = ["key1": "value1", "key2": "value2"]
    let dictionary = ["key": expectedValue]
    let decodedValue: JSONDictionary = try! dictionary.json(atKeyPath: "key")
    XCTAssert(decodedValue == expectedValue)

    let decodedOptionalInt: JSONDictionary? = dictionary.json(atKeyPath: "key")
    XCTAssert(decodedOptionalInt == expectedValue)

    expectDecodingError(reason: .keyNotFound, keyPath: randomKey) {
      let _ : JSONDictionary = try dictionary.json(atKeyPath: randomKey)
    }

    let decodedMissingInt: JSONDictionary? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }

  func testDecodingOfJSONRawTypesArray() {
    let expectedInt: [Int] = [1]
    expectDecodeTypeArray(expectedInt)

    let expectedFloat: [Float] = [2.2]
    expectDecodeTypeArray(expectedFloat)

    let expectedDouble: [Double] = [2.2]
    expectDecodeTypeArray(expectedDouble)

    let expectedString: [String] = ["something"]
    expectDecodeTypeArray(expectedString)

    let expectedBool: [Bool] = [true]
    expectDecodeTypeArray(expectedBool)
  }

  func testIncorrectEnum() {

    let dictionary = ["enum": "three"]

    expectDecodingError(reason: .keyNotFound, keyPath: "enumIncorrect") {
      let _ : MockParent.MockEnum = try dictionary.json(atKeyPath: "enumIncorrect")
    }

    expectDecodingError(reason: .incorrectRawRepresentableRawValue, keyPath: "enum") {
      let _ : MockParent.MockEnum = try dictionary.json(atKeyPath: "enum")
    }
  }

  func test_decodingMandatoryEnumDictionary_withKey() {
    let dictionary: JSONDictionary = ["enums": ["value1": "one", "value2": "!@1", "value3": "two"]]

    let decodedEnums: [String: MockParent.MockEnum] = try! dictionary.json(atKeyPath: "enums")

    let expectedEnums: [String: MockParent.MockEnum] = ["value1": .one, "value3": .two]
    XCTAssertEqual(decodedEnums, expectedEnums)
  }

  func test_decodingOptionalEnumDictionary_withKey() {
    let dictionary: JSONDictionary = ["enums": ["value1": "one", "value2": "!@1", "value3": "two"]]

    let decodedEnums: [String: MockParent.MockEnum]? = dictionary.json(atKeyPath: "enums")

    let expectedEnums: [String: MockParent.MockEnum] = ["value1": .one, "value3": .two]
    XCTAssertEqual(decodedEnums!, expectedEnums)
  }

  func test_decodingMandatoryEnumArray_withKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]

    let decodedEnums: [MockParent.MockEnum] = try! dictionary.json(atKeyPath: "enums")

    let expectedEnums: [MockParent.MockEnum] = [.one, .two]
    XCTAssertEqual(decodedEnums, expectedEnums)
  }

  func test_decodingOptionalEnumArray_withKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]

    let decodedEnums: [MockParent.MockEnum]? = dictionary.json(atKeyPath: "enums")

    let expectedEnums: [MockParent.MockEnum] = [.one, .two]
    XCTAssertEqual(decodedEnums!, expectedEnums)
  }

  func test_decodingMandatoryEnumArray_withoutKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]

    expectDecodingError(reason: .keyNotFound, keyPath: "invalid_key") {
      let _ : MockParent.MockEnum = try dictionary.json(atKeyPath: "invalid_key")
    }
  }

  func test_decodingOptionalEnumArray_withoutKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]

    let decodedEnums: [MockParent.MockEnum]? = dictionary.json(atKeyPath: "invalid_key")

    XCTAssertNil(decodedEnums)
  }

  func testDecodingOfJSONDictionaryArray() {

    let expectedValue: [JSONDictionary] = [["key1": "value1"], ["key2": "value2"]]
    let dictionary = ["key": expectedValue]
    let decodedValue: [JSONDictionary] = try! dictionary.json(atKeyPath: "key")
    XCTAssert(decodedValue == expectedValue)

    let decodedOptionalInt: [JSONDictionary]? = dictionary.json(atKeyPath: "key")
    XCTAssert(decodedOptionalInt == expectedValue)

    expectDecodingError(reason: .keyNotFound, keyPath: randomKey) {
      let _ : [JSONDictionary] = try dictionary.json(atKeyPath: randomKey)
    }

    let decodedMissingInt: [JSONDictionary]? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }

  func testSomeInvalidDecodableTypes() {
    let parentDictionary: JSONDictionary = ["children": ["john", ["name": "jane"]]]
    let decodedParent: MockSimpleParent = try! MockSimpleParent(jsonDictionary: parentDictionary)
    XCTAssert(decodedParent.children.count == 1)
  }

  // MARK: DecodingErrors

  func testDecodingErrorDescriptions() {
    let failureReasons: [JSONUtilities.DecodingError.Reason] = [
      .keyNotFound,
      .incorrectRawRepresentableRawValue,
      .incorrectType,
      .conversionFailure
    ]
    failureReasons.forEach {
      let error = DecodingError(dictionary: [:], keyPath: "", expectedType: String.self, value: "", array: nil, reason: $0)
      XCTAssert(error.description.count > 0)
      XCTAssert(error.debugDescription.count > 0)
      XCTAssert(error.reason.description.count > 0)
    }
  }

  // MARK: Helpers

  fileprivate func expectDecodeType<ExpectedType: JSONRawType & Equatable>(_ expectedValue: ExpectedType, file: StaticString = #file, line: UInt = #line) {

    let dictionary = ["key": expectedValue]
    let decodedValue: ExpectedType = try! dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedValue, expectedValue, file: file, line: line)

    let decodedOptionalInt: ExpectedType? = dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedOptionalInt!, expectedValue, file: file, line: line)

    expectDecodingError(reason: .keyNotFound, keyPath: randomKey) {
      let _ : ExpectedType = try dictionary.json(atKeyPath: randomKey)
    }

    let decodedMissingInt: ExpectedType? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }

  fileprivate func expectDecodeTypeArray<ExpectedType: JSONRawType & Equatable>(_ expectedValue: [ExpectedType], file: StaticString = #file, line: UInt = #line) {

    let dictionary = ["key": expectedValue]
    let decodedValue: [ExpectedType] = try! dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedValue, expectedValue, file: file, line: line)

    let decodedOptionalInt: [ExpectedType]? = dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedOptionalInt!, expectedValue, file: file, line: line)

    expectDecodingError(reason: .keyNotFound, keyPath: randomKey) {
      let _ : [ExpectedType] = try dictionary.json(atKeyPath: randomKey)
    }

    let decodedMissingInt: [ExpectedType]? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }
}
