//
//  TransformableTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 13/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

class TransformableTests: XCTestCase {

  func testDecodedAndTransformNSURL() {
    let urlString = "www.google.com"
    let expectedURL = NSURL(string: urlString)
    let jsonDictionary = [
      "url": urlString,
      "invalid_url": "±"
    ]
    
    let mandatoryTransformedURL : NSURL = try! jsonDictionary.jsonKey("url")
    XCTAssertEqual(expectedURL, mandatoryTransformedURL)
    let optionalTransformedURL : NSURL? = jsonDictionary.jsonKey("url")
    XCTAssertEqual(expectedURL, optionalTransformedURL)
    
    do {
      let _ : NSURL = try jsonDictionary.jsonKey("invalid_url")
    } catch let error {
      XCTAssertEqual("\(error)", "CouldNotTransformJSONValue: ±")
    }
  }
  
  func testDecodedAndTransformNSURL_missingKey() {
    let jsonDictionary = ["url": "url"]
    
    do {
      let _ : NSURL = try jsonDictionary.jsonKey("invalid_key")
    } catch let error {
      XCTAssertEqual("\(error)", "MandatoryKeyNotFound: invalid_key")
    }
    
    let urlFromMissingKey : NSURL? = jsonDictionary.jsonKey("invalid_key")
    XCTAssertNil(urlFromMissingKey)
  }

}

extension NSURL : Transformable {
  public typealias JSONType = String
  
  public static func fromJSONValue(jsonValue: String) -> Self? {
    return self.init(string: jsonValue)
  }
  
}