//
//  JSONUtilitiesTests.swift
//  JSONUtilitiesTests
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

class JSONUtilitiesTests: XCTestCase {
  
  func testLoadingJSONFile() {
    do {
      try JSONDictionary.fromFile(JSONFilename.correct, bundle: testBundle)
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testLoadingJSONFileLoadingFailed() {
    do {
      try JSONDictionary.fromFile(JSONFilename.missing, bundle: testBundle)
    } catch JSONUtilsError.FileLoadingFailed {
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testLoadingJSONFileDeserializationFailed() {
    do {
      try JSONDictionary.fromFile(JSONFilename.invalid, bundle: testBundle)
    } catch JSONUtilsError.FileDeserializationFailed {
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testLoadingJSONFileNotAJSONDictionary() {
    do {
      try JSONDictionary.fromFile(JSONFilename.array, bundle: testBundle)
    } catch JSONUtilsError.FileNotAJSONDictionary {
      XCTAssertTrue(true)
    } catch {
      XCTAssertTrue(false)
    }
  }
  
}
