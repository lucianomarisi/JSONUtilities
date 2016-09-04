//
//  MockParent.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
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
    mandatoryString = try jsonDictionary.jsonKeyPath("mandatoryStringKey")
    mandatoryInt = try jsonDictionary.jsonKeyPath("mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.jsonKeyPath("mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.jsonKeyPath("mandatoryBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.jsonKeyPath("mandatoryCustomJSONObjectKey")
    mandatoryCustomJSONObject = try jsonDictionary.jsonKeyPath("mandatoryCustomJSONObjectKey")
    mandatoryEnum = try jsonDictionary.jsonKeyPath("mandatoryEnum")
    
    optionalExistingString = jsonDictionary.jsonKeyPath("mandatoryStringKey")
    optionalExistingInt = jsonDictionary.jsonKeyPath("mandatoryIntKey")
    optionalExistingDouble = jsonDictionary.jsonKeyPath("mandatoryDoubleKey")
    optionalExistingBool = jsonDictionary.jsonKeyPath("mandatoryBoolKey")
    optionalExistingWeakDictionaryKey = jsonDictionary.jsonKeyPath("mandatoryCustomJSONObjectKey")
    optionalExistingCustomJSONObject = jsonDictionary.jsonKeyPath("mandatoryCustomJSONObjectKey")
    optionalExistingEnum = jsonDictionary.jsonKeyPath("mandatoryEnum")
    
    optionalMissingString = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingInt = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingDouble = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingBool = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingWeakDictionaryKey = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingCustomJSONObject = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingEnum = jsonDictionary.jsonKeyPath(randomKey)
    
    mandatoryArrayString = try jsonDictionary.jsonKeyPath("mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.jsonKeyPath("mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.jsonKeyPath("mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.jsonKeyPath("mandatoryArrayBoolKey")
    mandatoryWeakDictionaryArrayKey = try jsonDictionary.jsonKeyPath("mandatoryArrayCustomJSONObjectKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.jsonKeyPath("mandatoryArrayCustomJSONObjectKey")
    
    optionalExistingArrayString = jsonDictionary.jsonKeyPath("mandatoryArrayStringKey")
    optionalExistingArrayInt = jsonDictionary.jsonKeyPath("mandatoryArrayIntKey")
    optionalExistingArrayDouble = jsonDictionary.jsonKeyPath("mandatoryArrayDoubleKey")
    optionalExistingArrayBool = jsonDictionary.jsonKeyPath("mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryArrayKey = jsonDictionary.jsonKeyPath("mandatoryArrayCustomJSONObjectKey")
    optionalExistingArrayCustomJSONObject = jsonDictionary.jsonKeyPath("mandatoryArrayCustomJSONObjectKey")
    
    optionalMissingArrayString = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingArrayInt = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingArrayDouble = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingArrayBool = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingWeakDictionaryArrayKey = jsonDictionary.jsonKeyPath(randomKey)
    optionalMissingArrayCustomJSONObject = jsonDictionary.jsonKeyPath(randomKey)
  }
}
