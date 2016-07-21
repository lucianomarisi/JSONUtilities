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
  case MandatoryRawRepresentableHasIncorrectValue(rawRepresentable:Any, rawValue:JSONRawType)
  
  public var description: String {
    switch self {
    case .MandatoryKeyNotFound(let key):
      return "MandatoryKeyNotFound: \(key)"
    case .MandatoryRawRepresentableHasIncorrectValue(let rawRepresentable, let rawValue):
      return "MandatoryRawRepresentableHasIncorrectValue: \(rawRepresentable): \(rawValue)"
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