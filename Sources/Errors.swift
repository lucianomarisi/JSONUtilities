//
//  Errors.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

/**
 Decoding error for mandatory keys
 
 - Mandatory: The key that failed the decoding
 */
public enum DecodingError: ErrorProtocol, CustomStringConvertible {
  case mandatoryKeyNotFound(key: StringProtocol)
  
  public var description: String {
    switch self {
    case .mandatoryKeyNotFound(let key):
      return "MandatoryKeyNotFound: \(key)"
    }
  }
  
}

/**
 Error used when a json value fails to be transformed
 
 - CouldNotTransformJSONValue: The value that failed to be transformed
 */
public enum TranformableError<ValueType: JSONRawType>: ErrorProtocol, CustomStringConvertible {
  case couldNotTransformJSONValue(value: ValueType)
  
  public var description: String {
    switch self {
    case .couldNotTransformJSONValue(let value):
      return "CouldNotTransformJSONValue: \(value)"
    }
  }
  
}
