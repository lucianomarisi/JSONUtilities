//
//  MockSimpleChild.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation
@testable import JSONUtilities

struct MockSimpleChild {
  let name: String
}

extension MockSimpleChild: JSONObjectConvertible {
  
  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.jsonKeyPath("name")
  }
  
}
