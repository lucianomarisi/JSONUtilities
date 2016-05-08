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
  
  let expectedChildStruct = MockChildStruct(string: "stringValue", integer: 1, double: 1.2, bool: true)
  let expectedChildClass = MockChildClass(string: "stringValue", integer: 1, double: 1.2, bool: true)
  let expectedDictionary: JSONDictionary = ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true]
  let expectedDictionaryArray: [JSONDictionary] = [
    ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true],
    ["doubleKey": 1.2, "integerKey": 1, "stringKey": "stringValue", "boolKey": true],
    ["randomTypeObject": 123]
    ]

  lazy var testBundle : NSBundle = {
    return NSBundle(forClass: self.dynamicType)
  }()
  
  func testFailedMainBundle() {
    do {
      let _ = try JSONDictionary.fromFile(JSONFilename.correct)
      XCTAssertTrue(false)
    } catch {
      XCTAssertTrue(true)
    }
  }
  
  func testCorrectDecodingForMandatoryJSONOnStruct() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correct, bundle: testBundle)
      let mockJSONParent = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryString, "stringValue")
      XCTAssertEqual(mockJSONParent.mandatoryInt, 1)
      XCTAssertEqual(mockJSONParent.mandatoryDouble, 1.2)
      XCTAssertEqual(mockJSONParent.mandatoryBool, true)
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChildStruct)
      
      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChildStruct)
      
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
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChildStruct, expectedChildStruct])
      
      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1","2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1,2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayDouble!, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayBool!, [true, false])
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryArrayKey == expectedDictionaryArray)
      XCTAssertEqual(mockJSONParent.optionalExistingArrayCustomJSONObject!, [expectedChildStruct, expectedChildStruct])
      
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
  
  func testCorrectDecodingForMandatoryJSONOnClass() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correct, bundle: testBundle)
      let mockJSONParent = try MockParentClass(jsonDictionary: jsonDictionary)      
      XCTAssertEqual(mockJSONParent.mandatoryString, "stringValue")
      XCTAssertEqual(mockJSONParent.mandatoryInt, 1)
      XCTAssertEqual(mockJSONParent.mandatoryDouble, 1.2)
      XCTAssertEqual(mockJSONParent.mandatoryBool, true)
      XCTAssertTrue(mockJSONParent.mandatoryWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChildClass)
      
      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryKey == expectedDictionary)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChildClass)
      
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
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChildClass, expectedChildClass])
      
      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1","2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1,2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayDouble!, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayBool!, [true, false])
      XCTAssertTrue(mockJSONParent.optionalExistingWeakDictionaryArrayKey == expectedDictionaryArray)
      XCTAssertEqual(mockJSONParent.optionalExistingArrayCustomJSONObject!, [expectedChildClass, expectedChildClass])
      
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
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.empty, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONRawTypeArray() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutRawArray, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryArrayStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObject() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutNested, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObjectArray() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutNestedArray, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError {
      XCTAssertEqual(error.description, "MandatoryKeyNotFound: mandatoryArrayCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
}