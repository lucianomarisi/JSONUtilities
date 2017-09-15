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

  enum MockEnum: String {
    case one
    case two
  }

  // MARK: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryWeakDictionaryKey: JSONDictionary
  let mandatoryCustomJSONObject: MockChild
  let mandatoryEnum: MockEnum

  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingWeakDictionaryKey: JSONDictionary?
  let optionalExistingCustomJSONObject: MockChild?
  let optionalExistingEnum: MockEnum?

  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingWeakDictionaryKey: JSONDictionary?
  let optionalMissingCustomJSONObject: MockChild?
  let optionalMissingEnum: MockEnum?

  // MARK: Array properties
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

  let mandatoryIntDictionary: [String: Int]
  let mandatoryObjectDictionary: [String: MockChild]
  let mandatoryURLDictionary: [String: URL]
  let optionalIntDictionary: [String: Int]?
  let optionalObjectDictionary: [String: MockChild]?
  let optionalURLDictionary: [String: URL]?

  init(jsonDictionary: JSONDictionary) throws {
    mandatoryString = try jsonDictionary.json(atKeyPath: "keypath.mandatoryStringKey")
    mandatoryInt = try jsonDictionary.json(atKeyPath: "keypath.mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.json(atKeyPath: "keypath.mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.json(atKeyPath: "keypath.mandatoryBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    mandatoryCustomJSONObject = try jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    mandatoryEnum = try jsonDictionary.json(atKeyPath: "keypath.mandatoryEnum")

    optionalExistingString = jsonDictionary.json(atKeyPath: "keypath.mandatoryStringKey")
    optionalExistingInt = jsonDictionary.json(atKeyPath: "keypath.mandatoryIntKey")
    optionalExistingDouble = jsonDictionary.json(atKeyPath: "keypath.mandatoryDoubleKey")
    optionalExistingBool = jsonDictionary.json(atKeyPath: "keypath.mandatoryBoolKey")
    optionalExistingWeakDictionaryKey = jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    optionalExistingCustomJSONObject = jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    optionalExistingEnum = jsonDictionary.json(atKeyPath: "keypath.mandatoryEnum")

    optionalMissingString = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingInt = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingDouble = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingBool = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryKey = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingCustomJSONObject = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingEnum = jsonDictionary.json(atKeyPath: randomKey)

    mandatoryArrayString = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayBoolKey")
    mandatoryWeakDictionaryArrayKey = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")

    optionalExistingArrayString = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayStringKey")
    optionalExistingArrayInt = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayIntKey")
    optionalExistingArrayDouble = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayDoubleKey")
    optionalExistingArrayBool = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryArrayKey = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")
    optionalExistingArrayCustomJSONObject = jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")

    optionalMissingArrayString = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayInt = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayDouble = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayBool = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryArrayKey = jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayCustomJSONObject = jsonDictionary.json(atKeyPath: randomKey)

    mandatoryIntDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryIntDictionary")
    mandatoryObjectDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryObjectDictionary")
    mandatoryURLDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryURLDictionary")

    optionalIntDictionary = jsonDictionary.json(atKeyPath: "keypath.mandatoryIntDictionary")
    optionalObjectDictionary = jsonDictionary.json(atKeyPath: "keypath.mandatoryObjectDictionary")
    optionalURLDictionary = jsonDictionary.json(atKeyPath: "keypath.mandatoryURLDictionary")
  }
}
