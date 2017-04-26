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
public struct DecodingError: Error, CustomStringConvertible, CustomDebugStringConvertible {

  public var reason: Reason
  public let dictionary: [AnyHashable: Any]
  public let array: JSONArray?
  public let keyPath: String
  public let expectedType: Any
  public let value: Any

  init(dictionary: [AnyHashable: Any], keyPath: StringProtocol, expectedType: Any.Type, value: Any, array: JSONArray? = nil, reason: Reason) {
    self.dictionary = dictionary
    self.keyPath = keyPath.string
    self.expectedType = expectedType
    self.value = value
    self.reason = reason
    self.array = array
  }

  var reasonDescription: String {
    switch reason {
    case .keyNotFound:
      return "Nothing found"
    case .incorrectRawRepresentableRawValue:
      return "Incorrect rawValue of \(value) for \(expectedType)"
    case .incorrectType:
      return "Incorrect type, expected \(expectedType) found \(value)"
    case .conversionFailure:
      return "\(expectedType) failed to convert \(value)"
    }
  }

  public var description: String {
    return "Decoding failed at \"\(keyPath)\": \(reasonDescription)"
  }

  public var debugDescription: String {
    return "\(description):\n\(array?.description ?? dictionary.description)"
  }

  public enum Reason: String, CustomStringConvertible {

    case keyNotFound = "Key not found"
    case incorrectRawRepresentableRawValue = "Incorrect RawRepresentable RawValue"
    case incorrectType = "Incorrect type"
    case conversionFailure = "Conversion failure"

    public var description: String {
      return rawValue
    }
  }
}
