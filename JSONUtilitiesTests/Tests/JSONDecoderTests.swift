//
//  JSONDecoderTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
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

  func testFailedMainBundle() {
    do {
      let _ = try JSONDictionary.from(filename: JSONFilename.correct)
      XCTAssertTrue(false)
    } catch {
      XCTAssertTrue(true)
    }
  }
  
  func testCorrectDecodingForMandatoryJSONOnParentWithChild() {
    do {
      let jsonDictionary = try JSONDictionary.from(filename: JSONFilename.correct, bundle: testBundle)
      let mockJSONParent = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryString, "stringValue")
      XCTAssertEqual(mockJSONParent.mandatoryInt, 1)
      XCTAssertEqual(mockJSONParent.mandatoryDouble, 1.2)
      XCTAssertEqual(mockJSONParent.mandatoryBool, true)
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChild)
      
      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChild)
      
      XCTAssertNil(mockJSONParent.optionalMissingString)
      XCTAssertNil(mockJSONParent.optionalMissingInt)
      XCTAssertNil(mockJSONParent.optionalMissingDouble)
      XCTAssertNil(mockJSONParent.optionalMissingBool)
      XCTAssertNil(mockJSONParent.optionalMissingWeakDictionaryKey)
      XCTAssertNil(mockJSONParent.optionalMissingCustomJSONObject)
      
      XCTAssertEqual(mockJSONParent.mandatoryArrayString, ["1","2"])
      XCTAssertEqual(mockJSONParent.mandatoryArrayInt, [1,2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayDouble, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayBool, [true, false])
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryArrayKey == expectedDictionaryArray)
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChild, expectedChild])
      
      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1","2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1,2])
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
      
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: stringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONRawType() {
    do {
      let jsonDictionary = try JSONDictionary.from(filename: JSONFilename.empty, bundle: testBundle)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONRawTypeArray() {
    do {
      let jsonDictionary = try JSONDictionary.from(filename: JSONFilename.correctWithoutRawArray, bundle: testBundle)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryArrayStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObject() {
    do {
      let jsonDictionary = try JSONDictionary.from(filename: JSONFilename.correctWithoutNested, bundle: testBundle)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObjectArray() {
    do {
      let jsonDictionary = try JSONDictionary.from(filename: JSONFilename.correctWithoutNestedArray, bundle: testBundle)
      let _ = try MockParent(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryArrayCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
}
