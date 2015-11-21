//
//  MockChildStruct.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

struct MockMandatoryChild : Decodable {
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