//
//  JSONDecoderTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 Luciano Marisi All rights reserved.
//

import XCTest
@testable import JSONUtilities

class JSONDecoderTests: XCTestCase {

  let expectedChild = MockChild(string: "stringValue", integer: 1, double: 1.2, bool: true)
  let expectedDictionary: JSONDictionary = ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true]
  let expectedDictionaryArray: [JSONDictionary] = [
    ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true],
    ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true],
    ["randomTypeObject": 123]
    ]

  func testCorrectDecodingForMandatoryJSONOnParentWithChild() {
    do {
      let jsonDictionary = try JSONDictionary.from(url: JSONFilePath.correct)
      let mockJSONParent = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryString, "stringValue")
      XCTAssertEqual(mockJSONParent.mandatoryInt, 1)
      XCTAssertEqual(mockJSONParent.mandatoryDouble, 1.2)
      XCTAssertEqual(mockJSONParent.mandatoryBool, true)
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChild)
      XCTAssertEqual(mockJSONParent.mandatoryEnum, MockParent.MockEnum.one)

      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChild)
      XCTAssertEqual(mockJSONParent.optionalExistingEnum, MockParent.MockEnum.one)

      XCTAssertNil(mockJSONParent.optionalMissingString)
      XCTAssertNil(mockJSONParent.optionalMissingInt)
      XCTAssertNil(mockJSONParent.optionalMissingDouble)
      XCTAssertNil(mockJSONParent.optionalMissingBool)
      XCTAssertNil(mockJSONParent.optionalMissingWeakDictionaryKey)
      XCTAssertNil(mockJSONParent.optionalMissingCustomJSONObject)
      XCTAssertNil(mockJSONParent.optionalMissingEnum)

      XCTAssertEqual(mockJSONParent.mandatoryArrayString, ["1", "2"])
      XCTAssertEqual(mockJSONParent.mandatoryArrayInt, [1, 2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayDouble, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayBool, [true, false])
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryArrayKey == expectedDictionaryArray)
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChild, expectedChild])

      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1", "2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1, 2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayDouble!, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayBool!, [true, false])
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryArrayKey == expectedDictionaryArray)
      XCTAssertEqual(mockJSONParent.optionalExistingArrayCustomJSONObject!, [expectedChild, expectedChild])

      XCTAssertNil(mockJSONParent.optionalMissingArrayString)
      XCTAssertNil(mockJSONParent.optionalMissingArrayInt)
      XCTAssertNil(mockJSONParent.optionalMissingArrayDouble)
      XCTAssertNil(mockJSONParent.optionalMissingArrayBool)
      XCTAssertNil(mockJSONParent.optionalMissingWeakDictionaryArrayKey)
      XCTAssertNil(mockJSONParent.optionalMissingArrayCustomJSONObject)

      XCTAssertEqual(mockJSONParent.mandatoryIntDictionary, ["value1": 1, "value2": 2])
      XCTAssertEqual(mockJSONParent.mandatoryObjectDictionary, ["value1": expectedChild, "value2": expectedChild])
      XCTAssertEqual(mockJSONParent.mandatoryURLDictionary, ["value1": URL(string: "https://google.com")!, "value2": URL(string: "https://apple.com")!])
      XCTAssertEqual(mockJSONParent.optionalIntDictionary!, ["value1": 1, "value2": 2])
      XCTAssertEqual(mockJSONParent.optionalObjectDictionary!, ["value1": expectedChild, "value2": expectedChild])
      XCTAssertEqual(mockJSONParent.optionalURLDictionary!, ["value1": URL(string: "https://google.com")!, "value2": URL(string: "https://apple.com")!])

    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "mandatoryKeyNotFound: stringKey")
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }

  func testIncorrectDecodingForMandatoryJSONRawType() {
    do {
      let jsonDictionary = try JSONDictionary.from(url: JSONFilePath.empty)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch {
      let expectedError = DecodingError.keyNotFound(dictionary: [:], key: "mandatoryStringKey")
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func testIncorrectDecodingForMandatoryJSONRawTypeArray() {
    do {
      let jsonDictionary = try JSONDictionary.from(url: JSONFilePath.correctWithoutRawArray)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch {
      let expectedError = DecodingError.keyNotFound(dictionary: [:], key: "mandatoryArrayStringKey")
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func testIncorrectDecodingForMandatoryJSONNestedObject() {
    do {
      let jsonDictionary = try JSONDictionary.from(url: JSONFilePath.correctWithoutNested)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch {
      let expectedError = DecodingError.keyNotFound(dictionary: [:], key: "mandatoryCustomJSONObjectKey")
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func testIncorrectDecodingForMandatoryJSONNestedObjectArray() {
    do {
      let jsonDictionary = try JSONDictionary.from(url: JSONFilePath.correctWithoutNestedArray)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch {
      let expectedError = DecodingError.keyNotFound(dictionary: [:], key: "mandatoryArrayCustomJSONObjectKey")
      XCTAssert(error as? DecodingError == expectedError)
    }
  }
}
