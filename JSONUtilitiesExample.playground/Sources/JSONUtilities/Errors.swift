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
public enum DecodingError: ErrorType, CustomStringConvertible {
  case MandatoryKeyNotFound(key: StringProtocol)
  
  public var description: String {
    switch self {
    case .MandatoryKeyNotFound(let key):
      return "MandatoryKeyNotFound: \(key)"
    }
  }
  
}

/**
 Error used when a json value fails to be transformed
 
 - CouldNotTransformJSONValue: The value that failed to be transformed
 */
public enum TranformableError<ValueType: JSONRawType>: ErrorType, CustomStringConvertible {
  case CouldNotTransformJSONValue(value: ValueType)
  
  public var description: String {
    switch self {
    case .CouldNotTransformJSONValue(let value):
      return "CouldNotTransformJSONValue: \(value)"
    }
  }
  
}