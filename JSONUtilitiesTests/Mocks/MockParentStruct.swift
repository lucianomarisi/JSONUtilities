//
//  MockParentStruct.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

private let randomKey = "asdfghj"

struct MockMandatoryParent {
  
  // Mark: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryCustomJSONObject: MockMandatoryChild

  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingCustomJSONObject: MockMandatoryChild?

  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingCustomJSONObject: MockMandatoryChild?
  
  // Mark: Array properties
  let mandatoryArrayString: [String]
  let mandatoryArrayInt: [Int]
  let mandatoryArrayDouble: [Double]
  let mandatoryArrayBool: [Bool]
  let mandatoryArrayCustomJSONObject: [MockMandatoryChild]
  
  let optionalExistingArrayString: [String]?
  let optionalExistingArrayInt: [Int]?
  let optionalExistingArrayDouble: [Double]?
  let optionalExistingArrayBool: [Bool]?
  let optionalExistingArrayCustomJSONObject: [MockMandatoryChild]?
  
  let optionalMissingArrayString: [String]?
  let optionalMissingArrayInt: [Int]?
  let optionalMissingArrayDouble: [Double]?
  let optionalMissingArrayBool: [Bool]?
  let optionalMissingArrayCustomJSONObject: [MockMandatoryChild]?
  
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    mandatoryString = try decoder.decode("mandatoryStringKey")
    mandatoryInt = try decoder.decode("mandatoryIntKey")
    mandatoryDouble = try decoder.decode("mandatoryDoubleKey")
    mandatoryBool = try decoder.decode("mandatoryBoolKey")
    mandatoryCustomJSONObject = try decoder.decode("mandatoryCustomJSONObjectKey")

    optionalExistingString = decoder.decode("mandatoryStringKey")
    optionalExistingInt = decoder.decode("mandatoryIntKey")
    optionalExistingDouble = decoder.decode("mandatoryDoubleKey")
    optionalExistingBool = decoder.decode("mandatoryBoolKey")
    optionalExistingCustomJSONObject = decoder.decode("mandatoryCustomJSONObjectKey")
    
    optionalMissingString = decoder.decode(randomKey)
    optionalMissingInt = decoder.decode(randomKey)
    optionalMissingDouble = decoder.decode(randomKey)
    optionalMissingBool = decoder.decode(randomKey)
    optionalMissingCustomJSONObject = decoder.decode(randomKey)

    mandatoryArrayString = try decoder.decode("mandatoryArrayStringKey")
    mandatoryArrayInt = try decoder.decode("mandatoryArrayIntKey")
    mandatoryArrayDouble = try decoder.decode("mandatoryArrayDoubleKey")
    mandatoryArrayBool = try decoder.decode("mandatoryArrayBoolKey")
    mandatoryArrayCustomJSONObject = try decoder.decode("mandatoryArrayCustomJSONObjectKey")
    
    optionalExistingArrayString = decoder.decode("mandatoryArrayStringKey")
    optionalExistingArrayInt = decoder.decode("mandatoryArrayIntKey")
    optionalExistingArrayDouble = decoder.decode("mandatoryArrayDoubleKey")
    optionalExistingArrayBool = decoder.decode("mandatoryArrayBoolKey")
    optionalExistingArrayCustomJSONObject = decoder.decode("mandatoryArrayCustomJSONObjectKey")
    
    optionalMissingArrayString = decoder.decode(randomKey)
    optionalMissingArrayInt = decoder.decode(randomKey)
    optionalMissingArrayDouble = decoder.decode(randomKey)
    optionalMissingArrayBool = decoder.decode(randomKey)
    optionalMissingArrayCustomJSONObject = decoder.decode(randomKey)
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