//
//  FileLoadingTests.swift
//  FileLoadingTests
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

class FileLoadingTests: XCTestCase {
  
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
    } catch let error {
      XCTAssert(error as! JSONUtilsError == .FileLoadingFailed)
    }
  }
  
  func testLoadingJSONFileDeserializationFailed() {
    do {
      try JSONDictionary.fromFile(JSONFilename.invalid, bundle: testBundle)
    } catch let error {
      XCTAssert(error as! JSONUtilsError == .FileDeserializationFailed)
    }
  }

  func testLoadingJSONFileNotAJSONDictionary() {
    do {
      try JSONDictionary.fromFile(JSONFilename.array, bundle: testBundle)
    } catch let error {
      XCTAssert(error as! JSONUtilsError == .FileNotAJSONDictionary)
    }
  }
  
}
