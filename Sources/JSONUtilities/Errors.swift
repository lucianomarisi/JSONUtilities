//
//  Errors.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

/**
 Decoding error for mandatory keys

 - Mandatory: The key that failed the decoding
 */
public enum DecodingError: Error, CustomStringConvertible {
  case keyNotFound(dictionary: [AnyHashable: Any], key: StringProtocol)
  case incorrectRawRepresentableRawValue(rawRepresentable: Any.Type, rawValue: JSONRawType)
  case incorrectTypeInArray(array: JSONArray, expectedType: Any.Type, value: Any)
  case incorrectTypeInDictionary(dictionary: [AnyHashable: Any], key: StringProtocol, expectedType: Any.Type, value: Any)
  case conversionFailure(type: Any.Type, value: Any)

  public var description: String {
    switch self {
    case .keyNotFound(_, let key):
      return "Key not found: \(key)"
    case .incorrectRawRepresentableRawValue(let rawRepresentable, let rawValue):
      return "Incorrect rawValue for \(rawRepresentable): \(rawValue)"
    case .incorrectTypeInArray(_, let expectedType, let value):
      return "Incorrect type in [\(expectedType)]: \(value)"
    case .incorrectTypeInDictionary(_, let key, let expectedType, let value):
      return "Incorrect type in [String: \(expectedType)] for key \"\(key)\": \(value)"
    case .conversionFailure(let type, let value):
      return "\(type) failed to convert: \(value)"
    }
  }

  public var name: String {
    switch self {
    case .keyNotFound:
      return "Key not found"
    case .incorrectRawRepresentableRawValue:
      return "Incorrect RawRepresentable RawValue"
    case .incorrectTypeInArray:
      return "Incorrect type in array"
    case .incorrectTypeInDictionary:
      return "Incorrect type in dictionary"
    case .conversionFailure:
      return "Conversion failure"
    }
  }
}
