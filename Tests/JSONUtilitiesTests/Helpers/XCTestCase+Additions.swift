//
//  XCTestCase+Additions.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import XCTest
import JSONUtilities

extension XCTestCase {

  var testBundle: Bundle {
    return Bundle(for: type(of: self))
  }

  func expectDecodingError(reason: DecodingError.Reason, keyPath: String, decode: () throws -> Void) {
    do {
      try decode()
      XCTFail("Decoding was supposed to throw \"\(reason)\" error")
    } catch {
      guard let error = error as? DecodingError else {
        XCTFail("Error is not a Decoding Error")
        return
      }
      XCTAssertTrue(error.reason == reason, "DecodingError failed because of \"\(error.reason)\" but was supposed to fail for \"\(reason)\"")
      XCTAssertTrue(error.keyPath == keyPath, "DecodingError failed at keyPath \"\(error.keyPath)\", but was supposed to fail at \"\(keyPath)\"")
    }
  }
}
