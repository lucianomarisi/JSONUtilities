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
      mandatoryString : try decoder.decode("mandatoryStringKey"),
      mandatoryInt : try decoder.decode("mandatoryIntKey"),
      mandatoryDouble : try decoder.decode("mandatoryDoubleKey"),
      mandatoryBool : try decoder.decode("mandatoryBoolKey"),
      mandatoryCustomJSONObject : try decoder.decode("mandatoryCustomJSONObjectKey"),
      
      optionalExistingString : decoder.decode("mandatoryStringKey"),
      optionalExistingInt : decoder.decode("mandatoryIntKey"),
      optionalExistingDouble : decoder.decode("mandatoryDoubleKey"),
      optionalExistingBool : decoder.decode("mandatoryBoolKey"),
      optionalExistingCustomJSONObject : decoder.decode("mandatoryCustomJSONObjectKey"),
      
      optionalMissingString : decoder.decode(randomKey),
      optionalMissingInt : decoder.decode(randomKey),
      optionalMissingDouble : decoder.decode(randomKey),
      optionalMissingBool : decoder.decode(randomKey),
      optionalMissingCustomJSONObject : decoder.decode(randomKey),
      
      mandatoryArrayString : try decoder.decode("mandatoryArrayStringKey"),
      mandatoryArrayInt : try decoder.decode("mandatoryArrayIntKey"),
      mandatoryArrayDouble : try decoder.decode("mandatoryArrayDoubleKey"),
      mandatoryArrayBool : try decoder.decode("mandatoryArrayBoolKey"),
      mandatoryArrayCustomJSONObject : try decoder.decode("mandatoryArrayCustomJSONObjectKey"),
      
      optionalExistingArrayString : decoder.decode("mandatoryArrayStringKey"),
      optionalExistingArrayInt : decoder.decode("mandatoryArrayIntKey"),
      optionalExistingArrayDouble : decoder.decode("mandatoryArrayDoubleKey"),
      optionalExistingArrayBool : decoder.decode("mandatoryArrayBoolKey"),
      optionalExistingArrayCustomJSONObject : decoder.decode("mandatoryArrayCustomJSONObjectKey"),
      
      optionalMissingArrayString : decoder.decode(randomKey),
      optionalMissingArrayInt : decoder.decode(randomKey),
      optionalMissingArrayDouble : decoder.decode(randomKey),
      optionalMissingArrayBool : decoder.decode(randomKey),
      optionalMissingArrayCustomJSONObject : decoder.decode(randomKey)
    )
  }
}