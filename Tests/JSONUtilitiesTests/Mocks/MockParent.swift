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
    mandatoryString = try jsonDictionary.json(atKeyPath: "mandatoryStringKey")
    mandatoryInt = try jsonDictionary.json(atKeyPath: "mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.json(atKeyPath: "mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.json(atKeyPath: "mandatoryBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.json(atKeyPath: "mandatoryCustomJSONObjectKey")
    mandatoryCustomJSONObject = try jsonDictionary.json(atKeyPath: "mandatoryCustomJSONObjectKey")
    mandatoryEnum = try jsonDictionary.json(atKeyPath: "mandatoryEnum")
    
    optionalExistingString = jsonDictionary.json(atKeyPath: "mandatoryStringKey")
    optionalExistingInt = jsonDictionary.json(atKeyPath: "mandatoryIntKey")
    optionalExistingDouble = jsonDictionary.json(atKeyPath: "mandatoryDoubleKey")
    optionalExistingBool = jsonDictionary.json(atKeyPath: "mandatoryBoolKey")
    optionalExistingWeakDictionaryKey = jsonDictionary.json(atKeyPath: "mandatoryCustomJSONObjectKey")
    optionalExistingCustomJSONObject = jsonDictionary.json(atKeyPath: "mandatoryCustomJSONObjectKey")
    optionalExistingEnum = jsonDictionary.json(atKeyPath: "mandatoryEnum")
    
    optionalMissingString = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingInt = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingDouble = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingBool = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryKey = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingCustomJSONObject = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingEnum = jsonDictionary.json(atKeyPath: randomKey)
    
    mandatoryArrayString = try jsonDictionary.json(atKeyPath: "mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.json(atKeyPath: "mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.json(atKeyPath: "mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.json(atKeyPath: "mandatoryArrayBoolKey")
    mandatoryWeakDictionaryArrayKey = try jsonDictionary.json(atKeyPath: "mandatoryArrayCustomJSONObjectKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.json(atKeyPath: "mandatoryArrayCustomJSONObjectKey")
    
    optionalExistingArrayString = jsonDictionary.json(atKeyPath: "mandatoryArrayStringKey")
    optionalExistingArrayInt = jsonDictionary.json(atKeyPath: "mandatoryArrayIntKey")
    optionalExistingArrayDouble = jsonDictionary.json(atKeyPath: "mandatoryArrayDoubleKey")
    optionalExistingArrayBool = jsonDictionary.json(atKeyPath: "mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryArrayKey = jsonDictionary.json(atKeyPath: "mandatoryArrayCustomJSONObjectKey")
    optionalExistingArrayCustomJSONObject = jsonDictionary.json(atKeyPath: "mandatoryArrayCustomJSONObjectKey")
    
    optionalMissingArrayString = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayInt = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayDouble = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayBool = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryArrayKey = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayCustomJSONObject = jsonDictionary.json(atKeyPath: randomKey)
  }
}
