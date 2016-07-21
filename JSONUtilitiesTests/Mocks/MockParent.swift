//
//  MockParent.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation
@testable import JSONUtilities

private let randomKey = "asdfghj"

struct MockParent {
  
  enum MockEnum:String {
    case one
    case two
  }
  
  // Mark: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryWeakDictionaryKey: JSONDictionary
  let mandatoryCustomJSONObject: MockChild
  let mandatoryEnum:MockEnum
  
  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingWeakDictionaryKey: JSONDictionary?
  let optionalExistingCustomJSONObject: MockChild?
  let optionalExistingEnum:MockEnum?
  
  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingWeakDictionaryKey: JSONDictionary?
  let optionalMissingCustomJSONObject: MockChild?
  let optionalMissingEnum:MockEnum?
  
  // Mark: Array properties
  let mandatoryArrayString: [String]
  let mandatoryArrayInt: [Int]
  let mandatoryArrayDouble: [Double]
  let mandatoryArrayBool: [Bool]
  let mandatoryWeakDictionaryArrayKey: [JSONDictionary]
  let mandatoryArrayCustomJSONObject: [MockChild]
  
  let optionalExistingArrayString: [String]?
  let optionalExistingArrayInt: [Int]?
  let optionalExistingArrayDouble: [Double]?
  let optionalExistingArrayBool: [Bool]?
  let optionalExistingWeakDictionaryArrayKey: [JSONDictionary]?
  let optionalExistingArrayCustomJSONObject: [MockChild]?
  
  let optionalMissingArrayString: [String]?
  let optionalMissingArrayInt: [Int]?
  let optionalMissingArrayDouble: [Double]?
  let optionalMissingArrayBool: [Bool]?
  let optionalMissingWeakDictionaryArrayKey: [JSONDictionary]?
  let optionalMissingArrayCustomJSONObject: [MockChild]?
  
  init(jsonDictionary: JSONDictionary) throws {
    mandatoryString = try jsonDictionary.jsonKey("mandatoryStringKey")
    mandatoryInt = try jsonDictionary.jsonKey("mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.jsonKey("mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.jsonKey("mandatoryBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    mandatoryCustomJSONObject = try jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    mandatoryEnum = try jsonDictionary.jsonKey("mandatoryEnum")
    
    optionalExistingString = jsonDictionary.jsonKey("mandatoryStringKey")
    optionalExistingInt = jsonDictionary.jsonKey("mandatoryIntKey")
    optionalExistingDouble = jsonDictionary.jsonKey("mandatoryDoubleKey")
    optionalExistingBool = jsonDictionary.jsonKey("mandatoryBoolKey")
    optionalExistingWeakDictionaryKey = jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    optionalExistingCustomJSONObject = jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    optionalExistingEnum = jsonDictionary.jsonKey("mandatoryEnum")
    
    optionalMissingString = jsonDictionary.jsonKey(randomKey)
    optionalMissingInt = jsonDictionary.jsonKey(randomKey)
    optionalMissingDouble = jsonDictionary.jsonKey(randomKey)
    optionalMissingBool = jsonDictionary.jsonKey(randomKey)
    optionalMissingWeakDictionaryKey = jsonDictionary.jsonKey(randomKey)
    optionalMissingCustomJSONObject = jsonDictionary.jsonKey(randomKey)
    optionalMissingEnum = jsonDictionary.jsonKey(randomKey)
    
    mandatoryArrayString = try jsonDictionary.jsonKey("mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.jsonKey("mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.jsonKey("mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.jsonKey("mandatoryArrayBoolKey")
    mandatoryWeakDictionaryArrayKey = try jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    
    optionalExistingArrayString = jsonDictionary.jsonKey("mandatoryArrayStringKey")
    optionalExistingArrayInt = jsonDictionary.jsonKey("mandatoryArrayIntKey")
    optionalExistingArrayDouble = jsonDictionary.jsonKey("mandatoryArrayDoubleKey")
    optionalExistingArrayBool = jsonDictionary.jsonKey("mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryArrayKey = jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    optionalExistingArrayCustomJSONObject = jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    
    optionalMissingArrayString = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayInt = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayDouble = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayBool = jsonDictionary.jsonKey(randomKey)
    optionalMissingWeakDictionaryArrayKey = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayCustomJSONObject = jsonDictionary.jsonKey(randomKey)
  }
}