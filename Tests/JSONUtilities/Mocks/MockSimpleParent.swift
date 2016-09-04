//
//  MockSimpleParent.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation
@testable import JSONUtilities

struct MockSimpleParent {
  let children: [MockSimpleChild]
}

extension MockSimpleParent: JSONObjectConvertible {
  
  init(jsonDictionary: JSONDictionary) throws {
    children = try jsonDictionary.jsonKey("children")
  }
  
}
