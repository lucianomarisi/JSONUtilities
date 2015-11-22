//
//  MockChildStruct.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

struct MockChildStruct : Decodable {
  let string: String
  let integer: Int
  let double: Double
  let bool: Bool
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    string = try decoder.decode("stringKey")
    integer = try decoder.decode("integerKey")
    double = try decoder.decode("doubleKey")
    bool = try decoder.decode("boolKey")
  }
}

// MARK: Extensions necessary for testing

extension MockChildStruct {
  init(string: String, integer: Int, double: Double, bool: Bool) {
    self.string = string
    self.integer = integer
    self.double = double
    self.bool = bool
  }
}

extension MockChildStruct : Equatable {}
  
func == (lhs: MockChildStruct, rhs: MockChildStruct) -> Bool {
  return lhs.string == rhs.string &&
         lhs.integer == rhs.integer &&
         lhs.double == rhs.double &&
         lhs.bool == rhs.bool
}

