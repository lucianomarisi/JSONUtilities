//
//  Dictionary+Equatable.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 08/05/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
  return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

public func ==(lhs: [String: Any]?, rhs: [String: Any]? ) -> Bool {
  guard let lhs = lhs, let rhs = rhs else { return false }
  return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

public func ==(lhs: [[String: Any]], rhs: [[String: Any]] ) -> Bool {
  let lhsArray = NSArray(array: lhs)
  let rhsArray = NSArray(array: rhs)
  return lhsArray.isEqual(to: rhsArray as [AnyObject])
}

public func ==(lhs: [[String: Any]]?, rhs: [[String: Any]]? ) -> Bool {
  guard let lhs = lhs, let rhs = rhs else { return false }
  let lhsArray = NSArray(array: lhs)
  let rhsArray = NSArray(array: rhs)
  return lhsArray.isEqual(to: rhsArray as [AnyObject])
}
