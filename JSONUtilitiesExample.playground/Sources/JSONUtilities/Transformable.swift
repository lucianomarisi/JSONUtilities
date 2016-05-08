//
//  Transformable.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 13/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

/**
 *  Protocol used to support raw type other than JSON types, e.g. NSURL
 */
public protocol Transformable {
  
  /// The type of the raw JSON value that will be decoded to be transformed
  associatedtype JSONType: JSONRawType
  
  /**
   Create a type from a JSON value
   
   - parameter jsonValue: The value to transform
   
   - returns: An initialized type if succesful or nil
   */
  static func fromJSONValue(jsonValue: JSONType) -> Self?
}