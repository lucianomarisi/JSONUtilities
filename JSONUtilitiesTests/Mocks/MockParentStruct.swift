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

struct MockParentStruct {
  
  // Mark: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryCustomJSONObject: MockChildStruct

  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingCustomJSONObject: MockChildStruct?

  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingCustomJSONObject: MockChildStruct?
  
  // Mark: Array properties
  let mandatoryArrayString: [String]
  let mandatoryArrayInt: [Int]
  let mandatoryArrayDouble: [Double]
  let mandatoryArrayBool: [Bool]
  let mandatoryWeakDictionaryKey: [String: AnyObject]
  let mandatoryArrayCustomJSONObject: [MockChildStruct]
  
  let optionalExistingArrayString: [String]?
  let optionalExistingArrayInt: [Int]?
  let optionalExistingArrayDouble: [Double]?
  let optionalExistingArrayBool: [Bool]?
  let optionalExistingWeakDictionaryKey: [String: AnyObject]?
  let optionalExistingArrayCustomJSONObject: [MockChildStruct]?
  
  let optionalMissingArrayString: [String]?
  let optionalMissingArrayInt: [Int]?
  let optionalMissingArrayDouble: [Double]?
  let optionalMissingArrayBool: [Bool]?
  let optionalMissingWeakDictionaryKey: [String: AnyObject]?
  let optionalMissingArrayCustomJSONObject: [MockChildStruct]?
  

}


extension MockParentStruct {
  init(jsonDictionary: JSONDictionary) throws {
    mandatoryString = try jsonDictionary.jsonKey("mandatoryStringKey")
    mandatoryInt = try jsonDictionary.jsonKey("mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.jsonKey("mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.jsonKey("mandatoryBoolKey")
    mandatoryCustomJSONObject = try jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    
    optionalExistingString = jsonDictionary.jsonKey("mandatoryStringKey")
    optionalExistingInt = jsonDictionary.jsonKey("mandatoryIntKey")
    optionalExistingDouble = jsonDictionary.jsonKey("mandatoryDoubleKey")
    optionalExistingBool = jsonDictionary.jsonKey("mandatoryBoolKey")
    optionalExistingCustomJSONObject = jsonDictionary.jsonKey("mandatoryCustomJSONObjectKey")
    
    optionalMissingString = jsonDictionary.jsonKey(randomKey)
    optionalMissingInt = jsonDictionary.jsonKey(randomKey)
    optionalMissingDouble = jsonDictionary.jsonKey(randomKey)
    optionalMissingBool = jsonDictionary.jsonKey(randomKey)
    optionalMissingCustomJSONObject = jsonDictionary.jsonKey(randomKey)
    
    mandatoryArrayString = try jsonDictionary.jsonKey("mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.jsonKey("mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.jsonKey("mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.jsonKey("mandatoryArrayBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.jsonKey("mandatoryWeakDictionaryKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    
    optionalExistingArrayString = jsonDictionary.jsonKey("mandatoryArrayStringKey")
    optionalExistingArrayInt = jsonDictionary.jsonKey("mandatoryArrayIntKey")
    optionalExistingArrayDouble = jsonDictionary.jsonKey("mandatoryArrayDoubleKey")
    optionalExistingArrayBool = jsonDictionary.jsonKey("mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryKey = jsonDictionary.jsonKey("mandatoryWeakDictionaryKey")
    optionalExistingArrayCustomJSONObject = jsonDictionary.jsonKey("mandatoryArrayCustomJSONObjectKey")
    
    optionalMissingArrayString = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayInt = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayDouble = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayBool = jsonDictionary.jsonKey(randomKey)
    optionalMissingWeakDictionaryKey = jsonDictionary.jsonKey(randomKey)
    optionalMissingArrayCustomJSONObject = jsonDictionary.jsonKey(randomKey)
  }
}