//
//  Dictionary+KeyPath.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 04/09/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

extension Dictionary {

  /// Retrieves a value for a keyPath on the dictionary
  ///
  /// - parameter keyPath: A string of keys separated by dots
  ///
  /// - returns: Optionally returns a generic value for this keyPath or nil
  subscript(keyPath keyPath: StringProtocol) -> Any? {
    var keys = keyPath.components(separatedBy: ".")
    guard let firstKey = keys.first as? Key,
          let value = self[firstKey]
      else { return nil }

    keys.removeFirst()

    if !keys.isEmpty, let subDictionary = value as? [Key : Any] {
      let rejoined = keys.joined(separator: ".")
      return subDictionary[keyPath: rejoined]
    }
    return value
  }

}
