//
//  BundleFileLoadingTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 17/07/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

class BundleFileLoadingTests: XCTestCase {
  
  func testLoadFromBundle() {
    do {
      let _ = try JSONDictionary.from(filename: JSONFilename.correct, bundle: testBundle)
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
  
  func testAttemptToLoadMissingFileFromBundle() {
    do {
      let _ = try JSONDictionary.from(filename: JSONFilename.missing, bundle: testBundle)
    } catch let error as JSONUtilsError {
      XCTAssertEqual(error, JSONUtilsError.couldNotFindFile)
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
  
}
