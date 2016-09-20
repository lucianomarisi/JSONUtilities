//
//  FileLoadingTests.swift
//  FileLoadingTests
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 Luciano Marisi All rights reserved.
//

import XCTest
@testable import JSONUtilities

typealias NoEscapeFunction = ( () throws -> Void)

class FileLoadingTests: XCTestCase {
  
  func testLoadingJSONFile() {
    do {
      try JSONDictionary.from(url: JSONFilePath.correct)
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
  
  func testLoadingJSONFileLoadingFailed() {
    expectError(.fileLoadingFailed) {
      try JSONDictionary.from(url: JSONFilePath.missing)
    }
  }
  
  func testLoadingJSONFileDeserializationFailed() {
    expectError(.fileDeserializationFailed) {
      try JSONDictionary.from(url: JSONFilePath.invalid)
    }
  }

  func testLoadingJSONFileNotAJSONDictionary() {
    expectError(.fileNotAJSONDictionary) {
      try JSONDictionary.from(url: JSONFilePath.rootArray)
    }
  }
  
  // MARK: Helpers
  
  fileprivate func expectError(_ expectedError: JSONUtilsError, file: StaticString = #file, line: UInt = #line, block: NoEscapeFunction ) {
    do {
      try block()
    } catch let error {
      XCTAssert(error is JSONUtilsError, file: file, line: line)
      if let jsonUtilsError = error as? JSONUtilsError {
        XCTAssertEqual(jsonUtilsError, expectedError, file: file, line: line)
      }
      return
    }
    XCTFail("No error thrown, expected: \(expectedError)", file: file, line: line)
  }
  
}
