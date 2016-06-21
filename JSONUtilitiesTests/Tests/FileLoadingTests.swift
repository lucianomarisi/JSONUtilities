//
//  FileLoadingTests.swift
//  FileLoadingTests
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

typealias NoEscapeFunction = (@noescape () throws -> Void)

class FileLoadingTests: XCTestCase {
  
  func testLoadingJSONFile() {
    try! JSONDictionary.from(filename: JSONFilename.correct, bundle: testBundle)
  }
  
  func testLoadingJSONFileLoadingFailed() {
    expectError(.fileLoadingFailed) {
      try JSONDictionary.from(filename: JSONFilename.missing, bundle: self.testBundle)
    }
  }
  
  func testLoadingJSONFileDeserializationFailed() {
    expectError(.fileDeserializationFailed) {
      try JSONDictionary.from(filename: JSONFilename.invalid, bundle: self.testBundle)
    }
  }

  func testLoadingJSONFileNotAJSONDictionary() {
    expectError(.fileNotAJSONDictionary) {
      try JSONDictionary.from(filename: JSONFilename.rootArray, bundle: self.testBundle)
    }
  }
  
  // MARK: Helpers
  
  private func expectError(_ expectedError: JSONUtilsError, file: StaticString = #file, line: UInt = #line, block: NoEscapeFunction ) {
    do {
      try block()
    } catch let error {
      XCTAssert(error as! JSONUtilsError == expectedError, file: file, line: line)
      return
    }
    XCTFail("No error thrown, expected: \(expectedError)", file: file, line: line)
  }
  
}
