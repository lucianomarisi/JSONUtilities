//
//  Errors.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

/**
 Error that occurs when decoding
 */
public struct DecodingError: Error, CustomStringConvertible, CustomDebugStringConvertible {

  /// The reason the error occurred
  public var reason: Reason

  /// dictionary in which the error occured
  public let dictionary: [AnyHashable: Any]

  /// array in which the error occurred
  public let array: JSONArray?

  /// the keypath at which the error occurred
  public let keyPath: String

  /// the expected type that was being decoded while the error happened
  public let expectedType: Any

  /// the value that caused the error
  public let value: Any

  public init(dictionary: [AnyHashable: Any], keyPath: StringProtocol, expectedType: Any.Type, value: Any, array: JSONArray? = nil, reason: Reason) {
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

  /// The reason the error occurred
  public enum Reason: String, CustomStringConvertible {

    /// Key was not found in a JSONDictionary
    case keyNotFound = "Key not found"

    /// A value was found that can't initialise a RawRepresentable. In the case of an enum, the rawValue did not match any of the case's rawValue
    case incorrectRawRepresentableRawValue = "Incorrect RawRepresentable RawValue"

    /// The value has the incorrect type
    case incorrectType = "Incorrect type"

    /// A JSONPrimitiveConvertible failed to convert
    case conversionFailure = "Conversion failure"

    public var description: String {
      return rawValue
    }
  }
}
