//
//  MockSimpleParent.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation
@testable import JSONUtilities

struct MockSimpleParent {
  let children: [MockSimpleChild]
}

extension MockSimpleParent: Decodable {
  
  init(jsonDictionary: JSONDictionary) throws {
    children = try jsonDictionary.jsonKey("children")
  }
  
}
