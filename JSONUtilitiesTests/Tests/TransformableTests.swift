//
//  TransformableTests.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 13/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import XCTest
@testable import JSONUtilities

extension URL : Transformable {
  public typealias JSONType = String
  
  public static func fromJSONValue(_ jsonValue: String) -> URL? {
    return self.init(string: jsonValue)
  }
  
}

private let invalidKey = "invalidKey"

class TransformableTests: XCTestCase {

  func testDecodedAndTransformNSURL() {
    let urlString = "www.google.com"
    let expectedURL = URL(string: urlString)
    let jsonDictionary = [
      "url": urlString,
      "invalid_url": "±"
    ]
    
    let mandatoryTransformedURL : URL = try! jsonDictionary.jsonKey("url")
    XCTAssertEqual(expectedURL, mandatoryTransformedURL)
    let optionalTransformedURL : URL? = jsonDictionary.jsonKey("url")
    XCTAssertEqual(expectedURL, optionalTransformedURL)
    
    do {
      let _ : URL = try jsonDictionary.jsonKey("invalid_url")
    } catch let error {
      XCTAssertEqual("\(error)", "CouldNotTransformJSONValue: ±")
    }
  }
  
  func testDecodedAndTransformNSURL_missingKey() {
    let jsonDictionary = ["url": "url"]
    
    do {
      let _ : URL = try jsonDictionary.jsonKey(invalidKey)
    } catch let error {
      XCTAssertEqual("\(error)", "MandatoryKeyNotFound: \(invalidKey)")
    }
    
    let urlFromMissingKey : URL? = jsonDictionary.jsonKey(invalidKey)
    XCTAssertNil(urlFromMissingKey)
  }
  
  func testTransformableArray() {
    let expectedURLStrings = ["www.google.com", "www.apple.com"]
    let expectedURLs = expectedURLStrings.flatMap{ URL(string: $0) }
    let jsonDictionary = ["urls": expectedURLStrings]
    let decodedURLs: [URL] = try! jsonDictionary.jsonKey("urls")
    XCTAssertEqual(decodedURLs, expectedURLs)
    
    do {
      let _ : [URL] = try jsonDictionary.jsonKey(invalidKey)
    } catch let error {
      XCTAssertEqual("\(error)", "MandatoryKeyNotFound: \(invalidKey)")
    }
    
    let decodedOptionalURLs: [URL]? = jsonDictionary.jsonKey("urls")
    XCTAssertEqual(decodedOptionalURLs!, expectedURLs)
    
    let decodedMissingURLs: [URL]? = jsonDictionary.jsonKey(invalidKey)
    XCTAssertNil(decodedMissingURLs)
  }
  
}

