//
//  MockChild.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

struct MockChild {
  let string: String
  let integer: Int
  let double: Double
  let bool: Bool
}

extension MockChild : Decodable {
  init(jsonDictionary: JSONDictionary) throws {
    string = try jsonDictionary.jsonKey("stringKey")
    integer = try jsonDictionary.jsonKey("integerKey")
    double = try jsonDictionary.jsonKey("doubleKey")
    bool = try jsonDictionary.jsonKey("boolKey")
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
