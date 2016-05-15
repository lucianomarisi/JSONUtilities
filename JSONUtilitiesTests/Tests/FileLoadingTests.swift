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
    try! JSONDictionary.fromFile(JSONFilename.correct, bundle: testBundle)
  }
  
  func testLoadingJSONFileLoadingFailed() {
    expectError(.FileLoadingFailed) {
      try JSONDictionary.fromFile(JSONFilename.missing, bundle: testBundle)
    }
  }
  
  func testLoadingJSONFileDeserializationFailed() {
    expectError(.FileDeserializationFailed) {
      try JSONDictionary.fromFile(JSONFilename.invalid, bundle: testBundle)
    }
  }

  func testLoadingJSONFileNotAJSONDictionary() {
    expectError(.FileNotAJSONDictionary) {
      try JSONDictionary.fromFile(JSONFilename.rootArray, bundle: testBundle)
    }
  }
  
  // MARK: Helpers
  
  private func expectError(expectedError: JSONUtilsError, file: StaticString = #file, line: UInt = #line, @noescape block: (() throws -> Void) ) {
    do {
      try block()
    } catch let error {
      XCTAssert(error as! JSONUtilsError == expectedError, file: file, line: line)
      return
    }
    XCTFail("No error thrown, expected: \(expectedError)", file: file, line: line)
  }
  
}
