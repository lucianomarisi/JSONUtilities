//
//  MockChild.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation
@testable import JSONUtilities

struct MockChild {
  let string: String
  let integer: Int
  let double: Double
  let bool: Bool
}

extension MockChild : JSONObjectConvertible {
  init(jsonDictionary: JSONDictionary) throws {
    string = try jsonDictionary.json(atKeyPath: "stringKey")
    integer = try jsonDictionary.json(atKeyPath: "integerKey")
    double = try jsonDictionary.json(atKeyPath: "doubleKey")
    bool = try jsonDictionary.json(atKeyPath: "boolKey")
  }
}

// MARK: Extensions necessary for testing

extension MockChild : Equatable {}

func == (lhs: MockChild, rhs: MockChild) -> Bool {
  return lhs.string == rhs.string &&
    lhs.integer == rhs.integer &&
    lhs.double == rhs.double &&
    lhs.bool == rhs.bool
}
