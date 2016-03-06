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
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChildStruct)
      
      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChildStruct)
      
      XCTAssertEqual(mockJSONParent.optionalMissingString, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingInt, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingDouble, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingBool, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingCustomJSONObject, nil)
      
      XCTAssertEqual(mockJSONParent.mandatoryArrayString, ["1","2"])
      XCTAssertEqual(mockJSONParent.mandatoryArrayInt, [1,2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayDouble, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayBool, [true, false])
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChildStruct, expectedChildStruct])
      
      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1","2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1,2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayDouble!, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayBool!, [true, false])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayCustomJSONObject!, [expectedChildStruct, expectedChildStruct])
      
      XCTAssert(mockJSONParent.optionalMissingArrayString == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayInt == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayDouble == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayBool == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayCustomJSONObject == nil)
     
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: stringKey")
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
      XCTAssertEqual(mockJSONParent.mandatoryCustomJSONObject, expectedChildClass)
      
      XCTAssertEqual(mockJSONParent.optionalExistingString, "stringValue")
      XCTAssertEqual(mockJSONParent.optionalExistingInt, 1)
      XCTAssertEqual(mockJSONParent.optionalExistingDouble, 1.2)
      XCTAssertEqual(mockJSONParent.optionalExistingBool, true)
      XCTAssertEqual(mockJSONParent.optionalExistingCustomJSONObject, expectedChildClass)
      
      XCTAssertEqual(mockJSONParent.optionalMissingString, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingInt, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingDouble, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingBool, nil)
      XCTAssertEqual(mockJSONParent.optionalMissingCustomJSONObject, nil)
      
      XCTAssertEqual(mockJSONParent.mandatoryArrayString, ["1","2"])
      XCTAssertEqual(mockJSONParent.mandatoryArrayInt, [1,2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayDouble, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.mandatoryArrayBool, [true, false])
      XCTAssertEqual(mockJSONParent.mandatoryArrayCustomJSONObject, [expectedChildClass, expectedChildClass])
      
      XCTAssertEqual(mockJSONParent.optionalExistingArrayString!, ["1","2"])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayInt!, [1,2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayDouble!, [1.1, 1.2])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayBool!, [true, false])
      XCTAssertEqual(mockJSONParent.optionalExistingArrayCustomJSONObject!, [expectedChildClass, expectedChildClass])
      
      XCTAssert(mockJSONParent.optionalMissingArrayString == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayInt == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayDouble == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayBool == nil)
      XCTAssert(mockJSONParent.optionalMissingArrayCustomJSONObject == nil)
      
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: stringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }

  
  func testIncorrectDecodingForMandatoryJSONRawType() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.empty, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: mandatoryStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONRawTypeArray() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutRawArray, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: mandatoryArrayStringKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObject() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutNested, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: mandatoryCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testIncorrectDecodingForMandatoryJSONNestedObjectArray() {
    do {
      let jsonDictionary = try JSONDictionary.fromFile(JSONFilename.correctWithoutNestedArray, bundle: testBundle)
      let _ = try MockParentStruct(jsonDictionary: jsonDictionary)
      XCTAssertTrue(false)
    } catch let error as DecodingError<String> {
      XCTAssertEqual(error.description, "ParseError: mandatoryArrayCustomJSONObjectKey")
    } catch {
      XCTAssertTrue(false)
    }
  }
}