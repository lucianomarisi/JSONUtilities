//
//  MockParentClass.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 22/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

private let randomKey = "asdfghj"

final class MockParentClass {
  
  // Mark: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryCustomJSONObject: MockChildClass
  
  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingCustomJSONObject: MockChildClass?
  
  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingCustomJSONObject: MockChildClass?
  
  // Mark: Array properties
  let mandatoryArrayString: [String]
  let mandatoryArrayInt: [Int]
  let mandatoryArrayDouble: [Double]
  let mandatoryArrayBool: [Bool]
  let mandatoryArrayCustomJSONObject: [MockChildClass]
  
  let optionalExistingArrayString: [String]?
  let optionalExistingArrayInt: [Int]?
  let optionalExistingArrayDouble: [Double]?
  let optionalExistingArrayBool: [Bool]?
  let optionalExistingArrayCustomJSONObject: [MockChildClass]?
  
  let optionalMissingArrayString: [String]?
  let optionalMissingArrayInt: [Int]?
  let optionalMissingArrayDouble: [Double]?
  let optionalMissingArrayBool: [Bool]?
  let optionalMissingArrayCustomJSONObject: [MockChildClass]?
  
  // Memberwise initilizer needed because convenience initilizer can throw
  init(
    mandatoryString: String,
    mandatoryInt: Int,
    mandatoryDouble: Double,
    mandatoryBool: Bool,
    mandatoryCustomJSONObject: MockChildClass,
    optionalExistingString: String?,
    optionalExistingInt: Int?,
    optionalExistingDouble: Double?,
    optionalExistingBool: Bool?,
    optionalExistingCustomJSONObject: MockChildClass?,
    optionalMissingString: String?,
    optionalMissingInt: Int?,
    optionalMissingDouble: Double?,
    optionalMissingBool: Bool?,
    optionalMissingCustomJSONObject: MockChildClass?,
    mandatoryArrayString: [String],
    mandatoryArrayInt: [Int],
    mandatoryArrayDouble: [Double],
    mandatoryArrayBool: [Bool],
    mandatoryArrayCustomJSONObject: [MockChildClass],
    optionalExistingArrayString: [String]?,
    optionalExistingArrayInt: [Int]?,
    optionalExistingArrayDouble: [Double]?,
    optionalExistingArrayBool: [Bool]?,
    optionalExistingArrayCustomJSONObject: [MockChildClass]?,
    optionalMissingArrayString: [String]?,
    optionalMissingArrayInt: [Int]?,
    optionalMissingArrayDouble: [Double]?,
    optionalMissingArrayBool: [Bool]?,
    optionalMissingArrayCustomJSONObject: [MockChildClass]?
    )
  {
    self.mandatoryString = mandatoryString
    self.mandatoryInt = mandatoryInt
    self.mandatoryDouble = mandatoryDouble
    self.mandatoryBool = mandatoryBool
    self.mandatoryCustomJSONObject = mandatoryCustomJSONObject
    self.optionalExistingString = optionalExistingString
    self.optionalExistingInt = optionalExistingInt
    self.optionalExistingDouble = optionalExistingDouble
    self.optionalExistingBool = optionalExistingBool
    self.optionalExistingCustomJSONObject = optionalExistingCustomJSONObject
    self.optionalMissingString = optionalMissingString
    self.optionalMissingInt = optionalMissingInt
    self.optionalMissingDouble = optionalMissingDouble
    self.optionalMissingBool = optionalMissingBool
    self.optionalMissingCustomJSONObject = optionalMissingCustomJSONObject
    self.mandatoryArrayString = mandatoryArrayString
    self.mandatoryArrayInt = mandatoryArrayInt
    self.mandatoryArrayDouble = mandatoryArrayDouble
    self.mandatoryArrayBool = mandatoryArrayBool
    self.mandatoryArrayCustomJSONObject = mandatoryArrayCustomJSONObject
    self.optionalExistingArrayString = optionalExistingArrayString
    self.optionalExistingArrayInt = optionalExistingArrayInt
    self.optionalExistingArrayDouble =  optionalExistingArrayDouble
    self.optionalExistingArrayBool = optionalExistingArrayBool
    self.optionalExistingArrayCustomJSONObject = optionalExistingArrayCustomJSONObject
    self.optionalMissingArrayString = optionalMissingArrayString
    self.optionalMissingArrayInt = optionalMissingArrayInt
    self.optionalMissingArrayDouble = optionalMissingArrayDouble
    self.optionalMissingArrayBool = optionalMissingArrayBool
    self.optionalMissingArrayCustomJSONObject = optionalMissingArrayCustomJSONObject
  }
}

extension MockParentClass {
  
  // Convenience initializer used instead of designated because swift does not support partially initiated classes
  convenience init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    self.init(
      mandatoryString : try jsonDictionary.jsonKey("mandatoryStringKey"),
      mandatoryInt : try jsonDictionary.jsonKey("mandatoryIntKey"),
      mandatoryDouble : try jsonDictionary.jsonKey("mandatoryDoubleKey"),
      mandatoryBool : try jsonDictionary.jsonKey("mandatoryBoolKey"),
      mandatoryCustomJSONObject : try jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey"),
      
      optionalExistingString : jsonDictionary.jsonKey("mandatoryStringKey"),
      optionalExistingInt : jsonDictionary.jsonKey("mandatoryIntKey"),
      optionalExistingDouble : jsonDictionary.jsonKey("mandatoryDoubleKey"),
      optionalExistingBool : jsonDictionary.jsonKey("mandatoryBoolKey"),
      optionalExistingCustomJSONObject : jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey"),
      
      optionalMissingString : jsonDictionary.jsonKey(randomKey),
      optionalMissingInt : jsonDictionary.jsonKey(randomKey),
      optionalMissingDouble : jsonDictionary.jsonKey(randomKey),
      optionalMissingBool : jsonDictionary.jsonKey(randomKey),
      optionalMissingCustomJSONObject : jsonDictionary.jsonKey(randomKey),
      
      mandatoryArrayString : try jsonDictionary.jsonKey("mandatoryArrayStringKey"),
      mandatoryArrayInt : try jsonDictionary.jsonKey("mandatoryArrayIntKey"),
      mandatoryArrayDouble : try jsonDictionary.jsonKey("mandatoryArrayDoubleKey"),
      mandatoryArrayBool : try jsonDictionary.jsonKey("mandatoryArrayBoolKey"),
      mandatoryArrayCustomJSONObject : try jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey"),
      
      optionalExistingArrayString : jsonDictionary.jsonKey("mandatoryArrayStringKey"),
      optionalExistingArrayInt : jsonDictionary.jsonKey("mandatoryArrayIntKey"),
      optionalExistingArrayDouble : jsonDictionary.jsonKey("mandatoryArrayDoubleKey"),
      optionalExistingArrayBool : jsonDictionary.jsonKey("mandatoryArrayBoolKey"),
      optionalExistingArrayCustomJSONObject : jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey"),
      
      optionalMissingArrayString : jsonDictionary.jsonKey(randomKey),
      optionalMissingArrayInt : jsonDictionary.jsonKey(randomKey),
      optionalMissingArrayDouble : jsonDictionary.jsonKey(randomKey),
      optionalMissingArrayBool : jsonDictionary.jsonKey(randomKey),
      optionalMissingArrayCustomJSONObject : jsonDictionary.jsonKey(randomKey)
    )
  }
}