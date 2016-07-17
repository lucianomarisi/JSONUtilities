//
//  XCTestCase+Additions.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import XCTest

extension XCTestCase {
  
  var testBundle: Bundle {
    return Bundle(for: self.dynamicType)
  }
  
}
