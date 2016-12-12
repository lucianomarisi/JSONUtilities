//
//  URL+JSONPrimitiveConvertible.swift
//  JSONUtilities
//
//  Created by Sam Dods on 14/09/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation

extension URL: JSONPrimitiveConvertible {

  public typealias JSONType = String

  /// Creates a URL from a string, in order to conform to JSONPrimitiveConvertible
  ///
  /// - parameter jsonValue: The string representation of a valid URL
  ///
  /// - returns: Returns a URL if the input string was successfully converted to a URL
  public static func from(jsonValue: String) -> URL? {
    return URL(string: jsonValue)
  }

}
