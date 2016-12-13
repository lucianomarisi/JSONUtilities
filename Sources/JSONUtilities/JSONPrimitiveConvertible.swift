//
//  JSONPrimitiveConvertible.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 13/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

/**
 *  Protocol used to support raw primitive types other than object types, e.g. NSURL
 */
public protocol JSONPrimitiveConvertible {

  /// The type of the raw JSON value that will be decoded to be transformed
  associatedtype JSONType: JSONRawType

  /**
   Create a type from a JSON value
   
   - parameter jsonValue: The value to transform
   
   - returns: An initialized type if succesful or nil
   */
  static func from(jsonValue: JSONType) -> Self?
}
