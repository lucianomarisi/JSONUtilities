//
//  Dictionary+Equatable.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 08/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

public func ==(lhs: [String: AnyObject], rhs: [String: AnyObject] ) -> Bool {
  return NSDictionary(dictionary: lhs).isEqualToDictionary(rhs)
}

public func ==(lhs: [String: AnyObject]?, rhs: [String: AnyObject]? ) -> Bool {
  guard let lhs = lhs, rhs = rhs else { return false }
  return NSDictionary(dictionary: lhs).isEqualToDictionary(rhs)
}

public func ==(lhs: [[String: AnyObject]], rhs: [[String: AnyObject]] ) -> Bool {
  let lhsArray = NSArray(array: lhs)
  let rhsArray = NSArray(array: rhs)
  return lhsArray.isEqualToArray(rhsArray as [AnyObject])
}

public func ==(lhs: [[String: AnyObject]]?, rhs: [[String: AnyObject]]? ) -> Bool {
  guard let lhs = lhs, rhs = rhs else { return false }
  let lhsArray = NSArray(array: lhs)
  let rhsArray = NSArray(array: rhs)
  return lhsArray.isEqualToArray(rhsArray as [AnyObject])
}