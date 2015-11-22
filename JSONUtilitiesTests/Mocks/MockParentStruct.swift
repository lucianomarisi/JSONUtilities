//
//  MockParentStruct.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

struct MockMandatoryParent {
  
  let string: String
  let integer: Int
  let double: Double
  let bool: Bool
  let nestedObject: MockMandatoryChild
  let optionalNestedObject: MockMandatoryChild?
  let incorrectKeyNestedObject: MockMandatoryChild?

  let nestedObjectsArray: [MockMandatoryChild]
  let optionalNestedObjectsArray: [MockMandatoryChild]?

  let stringArray: [String]
  let integerArray: [Int]
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    string = try decoder.decode("stringKey")
    integer = try decoder.decode("integerKey")
    double = try decoder.decode("doubleKey")
    bool = try decoder.decode("boolKey")
    nestedObject = try decoder.decode("nestedObjectKey")
    optionalNestedObject = decoder.decode("nestedObjectKey")
    incorrectKeyNestedObject = decoder.decode("incorrectKeyNestedObject")
    nestedObjectsArray = try decoder.decode("nestedObjectsArrayKey")
    optionalNestedObjectsArray = decoder.decode("optionalNestedObjectsArray")
    stringArray = try decoder.decode("stringArrayKey")
    integerArray = try decoder.decode("integerArrayKey")
  }
}

struct OptionalMockJSONStructure {
  let string: String?
  let integer: Int?
  let double: Double?
  let bool: Bool?
  let nestedObject: MockMandatoryChild?
  let stringArray: [String]?
  let integerArray: [Int]?
  
  init(jsonDictionary: JSONDictionary) {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    string = decoder.decode("stringKey")
    integer = decoder.decode("integerKey")
    double = decoder.decode("doubleKey")
    bool = decoder.decode("boolKey")
    nestedObject = try? decoder.decode("nestedObjectKey")
    stringArray = decoder.decode("stringArrayKey")
    integerArray = decoder.decode("integerArrayKey")
  }
}