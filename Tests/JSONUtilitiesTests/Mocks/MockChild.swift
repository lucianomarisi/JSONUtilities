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
    string = try jsonDictionary.jsonKeyPath("stringKey")
    integer = try jsonDictionary.jsonKeyPath("integerKey")
    double = try jsonDictionary.jsonKeyPath("doubleKey")
    bool = try jsonDictionary.jsonKeyPath("boolKey")
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
