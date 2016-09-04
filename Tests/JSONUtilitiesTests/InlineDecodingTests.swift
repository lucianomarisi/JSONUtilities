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
    let decodedValue: JSONDictionary = try! dictionary.jsonKeyPath("key")
    XCTAssert(decodedValue == expectedValue)
    
    let decodedOptionalInt: JSONDictionary? = dictionary.jsonKeyPath("key")
    XCTAssert(decodedOptionalInt == expectedValue)
    
    do {
      let _: JSONDictionary = try dictionary.jsonKeyPath(randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as! DecodingError
      XCTAssert(actualError == expectedError)
    }
    
    let decodedMissingInt: JSONDictionary? = dictionary.jsonKeyPath(randomKey)
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
      let _:MockParent.MockEnum = try dictionary.jsonKeyPath("enumIncorrect")
      XCTAssertThrowsError("Did not catch mandatoryKeyNotFound error")
    }
    catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: "enumIncorrect")
      let actualError = error as! DecodingError
      XCTAssert(expectedError == actualError)
    }
    
    do {
      let _:MockParent.MockEnum = try dictionary.jsonKeyPath("enum")
      XCTAssertThrowsError("Did not catch mandatoryRawRepresentableHasIncorrectValue error")
    }
    catch let error {
      let expectedError = DecodingError.mandatoryRawRepresentableHasIncorrectValue(rawRepresentable: MockParent.MockEnum.self, rawValue: "three")
      let actualError = error as! DecodingError
      XCTAssert(expectedError == actualError)
    }
  }
  
  func test_decodingMandatoryEnumArray_withKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]
    
    let decodedEnums: [MockParent.MockEnum] = try! dictionary.jsonKeyPath("enums")
    
    let expectedEnums: [MockParent.MockEnum] = [.one, .two]
    XCTAssertEqual(decodedEnums, expectedEnums)
  }

  
  func test_decodingOptionalEnumArray_withKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]
    
    let decodedEnums: [MockParent.MockEnum]? = dictionary.jsonKeyPath("enums")
    
    let expectedEnums: [MockParent.MockEnum] = [.one, .two]
    XCTAssertEqual(decodedEnums!, expectedEnums)
  }
  
  func test_decodingMandatoryEnumArray_withoutKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]
    
    do {
      let _: [MockParent.MockEnum] = try dictionary.jsonKeyPath("invalid_key")
      XCTFail("Error not thrown")
    } catch {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: "invalid_key")
      XCTAssert(error as! DecodingError == expectedError)
    }

  }
  
  func test_decodingOptionalEnumArray_withoutKey() {
    let dictionary: JSONDictionary = ["enums": ["one", "!@1", "two"]]
    
    let decodedEnums: [MockParent.MockEnum]? = dictionary.jsonKeyPath("invalid_key")
    
    XCTAssertNil(decodedEnums)
  }
  
  func testDecodingOfJSONDictionaryArray() {
    
    let expectedValue: [JSONDictionary] = [["key1": "value1"], ["key2": "value2"]]
    let dictionary = ["key": expectedValue]
    let decodedValue: [JSONDictionary] = try! dictionary.jsonKeyPath("key")
    XCTAssert(decodedValue == expectedValue)
    
    let decodedOptionalInt: [JSONDictionary]? = dictionary.jsonKeyPath("key")
    XCTAssert(decodedOptionalInt == expectedValue)
    
    do {
      let _: [JSONDictionary] = try dictionary.jsonKeyPath(randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as! DecodingError
      XCTAssert(actualError == expectedError)
    }
    
    let decodedMissingInt: [JSONDictionary]? = dictionary.jsonKeyPath(randomKey)
    XCTAssertNil(decodedMissingInt)
  }
  
  func testSomeInvalidDecodableTypes() {
    let parentDictionary: JSONDictionary = ["children" : ["john", ["name": "jane"]]]
    let decodedParent: MockSimpleParent = try! MockSimpleParent(jsonDictionary: parentDictionary)
    XCTAssert(decodedParent.children.count == 1)
  }
  
  // MARK: Helpers
  
  fileprivate func expectDecodeType<ExpectedType: JSONRawType & Equatable>(_ expectedValue: ExpectedType, file: StaticString = #file, line: UInt = #line) {
    
    let dictionary = ["key": expectedValue]
    let decodedValue: ExpectedType = try! dictionary.jsonKeyPath("key")
    XCTAssertEqual(decodedValue, expectedValue, file: file, line: line)
    
    let decodedOptionalInt: ExpectedType? = dictionary.jsonKeyPath("key")
    XCTAssertEqual(decodedOptionalInt!, expectedValue, file: file, line: line)
    
    do {
      let _: ExpectedType = try dictionary.jsonKeyPath(randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as! DecodingError
      XCTAssert(actualError == expectedError, file: file, line: line)
    }
    
    let decodedMissingInt: ExpectedType? = dictionary.jsonKeyPath(randomKey)
    XCTAssertNil(decodedMissingInt)
  }

  fileprivate func expectDecodeTypeArray<ExpectedType: JSONRawType & Equatable>(_ expectedValue: [ExpectedType], file: StaticString = #file, line: UInt = #line) {
    
    let dictionary = ["key": expectedValue]
    let decodedValue: [ExpectedType] = try! dictionary.jsonKeyPath("key")
    XCTAssertEqual(decodedValue, expectedValue, file: file, line: line)
    
    let decodedOptionalInt: [ExpectedType]? = dictionary.jsonKeyPath("key")
    XCTAssertEqual(decodedOptionalInt!, expectedValue, file: file, line: line)
    
    do {
      let _: [ExpectedType] = try dictionary.jsonKeyPath(randomKey)
    } catch let error {
      let expectedError = DecodingError.mandatoryKeyNotFound(key: randomKey)
      let actualError = error as! DecodingError
      XCTAssert(actualError == expectedError, file: file, line: line)
    }
    
    let decodedMissingInt: [ExpectedType]? = dictionary.jsonKeyPath(randomKey)
    XCTAssertNil(decodedMissingInt)
  }
  
}

func ==(lhs: DecodingError, rhs: DecodingError) -> Bool {
  return lhs.description == rhs.description
}
