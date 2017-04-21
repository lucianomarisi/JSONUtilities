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

    do {
      let _: JSONDictionary = try dictionary.json(atKeyPath: randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as? DecodingError
      XCTAssert(actualError == expectedError)
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

    do {
      let _:MockParent.MockEnum = try dictionary.json(atKeyPath: "enumIncorrect")
      XCTAssertThrowsError("Did not catch mandatoryKeyNotFound error")
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: "enumIncorrect")
      let actualError = error as? DecodingError
      XCTAssert(expectedError == actualError)
    }

    do {
      let _:MockParent.MockEnum = try dictionary.json(atKeyPath: "enum")
      XCTAssertThrowsError("Did not catch mandatoryRawRepresentableHasIncorrectValue error")
    } catch let error {
      let expectedError = DecodingError.mandatoryRawRepresentableHasIncorrectValue(rawRepresentable: MockParent.MockEnum.self, rawValue: "three")
      let actualError = error as? DecodingError
      XCTAssert(expectedError == actualError)
    }
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

    do {
      let _: [MockParent.MockEnum] = try dictionary.json(atKeyPath: "invalid_key")
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: "invalid_key")
      XCTAssert(error as? DecodingError == expectedError)
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

    do {
      let _: [JSONDictionary] = try dictionary.json(atKeyPath: randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as? DecodingError
      XCTAssert(actualError == expectedError)
    }

    let decodedMissingInt: [JSONDictionary]? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }

  func testSomeInvalidDecodableTypes() {
    let parentDictionary: JSONDictionary = ["children": ["john", ["name": "jane"]]]
    let decodedParent: MockSimpleParent = try! MockSimpleParent(jsonDictionary: parentDictionary)
    XCTAssert(decodedParent.children.count == 1)
  }

  // MARK: Dictionary invalidItemBehaviour

  func test_stringJSONRawTypeDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": "value1",
        "key2": 2
      ]
    ]
    do {
      let _: [String: String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: "key2")
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func test_stringJSONPrimitiveConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": "www.google.com",
        "key2": 2
      ]
    ]
    do {
      let _: [String: URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.incorrectTypeForKey(key: "key2", expected: String.self, found: 2)
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func test_stringJSONObjectConvertibleDictionaryFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "key1": ["name": "john"],
        "key2": 2
      ]
    ]
    do {
      let _: [String: MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.incorrectTypeForKey(key: "key2", expected: JSONDictionary.self, found: 2)
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

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

  // MARK: Array invalidItemBehaviour

  func test_stringJSONRawTypeArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "value1",
        2
      ]
    ]
    do {
      let _: [String] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.incorrectType(expected: String.self, found: 2)
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func test_stringJSONPrimitiveConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        "www.google.com",
        2
      ]
    ]
    do {
      let _: [URL] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.incorrectType(expected: String.self, found: 2)
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

  func test_stringJSONObjectConvertibleArrayFails_whenThereAreInvalidObjects_and_invalidItemBehaviourIsThrow() {
    let dictionary = [
      "key": [
        ["name": "john"],
        2
      ]
    ]
    do {
      let _: [MockSimpleChild] = try dictionary.json(atKeyPath: "key", invalidItemBehaviour: .throw)
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.incorrectType(expected: JSONDictionary.self, found: 2)
      print(error)
      XCTAssert(error as? DecodingError == expectedError)
    }
  }

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

  // MARK: Helpers

  fileprivate func expectDecodeType<ExpectedType: JSONRawType & Equatable>(_ expectedValue: ExpectedType, file: StaticString = #file, line: UInt = #line) {

    let dictionary = ["key": expectedValue]
    let decodedValue: ExpectedType = try! dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedValue, expectedValue, file: file, line: line)

    let decodedOptionalInt: ExpectedType? = dictionary.json(atKeyPath: "key")
    XCTAssertEqual(decodedOptionalInt!, expectedValue, file: file, line: line)

    do {
      let _: ExpectedType = try dictionary.json(atKeyPath: randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as? DecodingError
      XCTAssert(actualError == expectedError, file: file, line: line)
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

    do {
      let _: [ExpectedType] = try dictionary.json(atKeyPath: randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as? DecodingError
      XCTAssert(actualError == expectedError, file: file, line: line)
    }

    let decodedMissingInt: [ExpectedType]? = dictionary.json(atKeyPath: randomKey)
    XCTAssertNil(decodedMissingInt)
  }

}

func == (lhs: DecodingError?, rhs: DecodingError?) -> Bool {
  guard let lhs = lhs, let rhs = rhs else { return false }
  return lhs.description == rhs.description
}
