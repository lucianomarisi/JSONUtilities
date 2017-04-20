//
//  Dictionary+JSONKey.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

/// Protocol used for defining the valid JSON types, i.e. Int, Double, Float, String and Bool
public protocol JSONRawType {}
extension Int : JSONRawType {}
extension Double : JSONRawType {}
extension Float : JSONRawType {}
extension String : JSONRawType {}
extension Bool : JSONRawType {}

/// The behaviour of what should be done when an invalid JSON object or primitive is found
///
/// - remove: The item is filtered, only valid items are returned
/// - throw:  The call fails by throwing on any invalid item
public enum InvalidItemBehaviour {
  case remove
  case `throw`
}

// Simple protocol used to extend a JSONDictionary
public protocol StringProtocol {
  func components(separatedBy: String) -> [String]
}
extension String: StringProtocol {}

extension Dictionary where Key: StringProtocol {

  // MARK: JSONRawType type

  /// Decode a mandatory JSON raw type
  public func json<ReturnType: JSONRawType>(atKeyPath keyPath: Key) throws -> ReturnType {

    guard let value = self[keyPath: keyPath] as? ReturnType else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return value
  }

  /// Decode an optional JSON raw type
  public func json<ReturnType: JSONRawType>(atKeyPath keyPath: Key) -> ReturnType? {
    return self[keyPath: keyPath] as? ReturnType
  }

  // MARK: [JSONRawType] type

  /// Decode an Array of mandatory JSON raw types
  public func json<ReturnType: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [ReturnType] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { $0 as? ReturnType }
  }

  /// Decode an Array of optional JSON raw types
  public func json<ReturnType: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [ReturnType]? {
    return try? self.json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour)
  }

  // MARK: [String: Any] type

  /// Decodes as a raw Dictionary with a mandatory key
  public func json(atKeyPath keyPath: Key) throws -> JSONDictionary {

    guard let value = self[keyPath: keyPath] as? JSONDictionary else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return value
  }

  /// Decodes as a raw dictionary with an optional key
  public func json(atKeyPath keyPath: Key) -> JSONDictionary? {
    return self[keyPath: keyPath] as? JSONDictionary
  }

  // MARK: [[String: Any]] type

  /// Decodes as a raw dictionary array with a mandatory key
  public func json(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [JSONDictionary] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { $0 as? JSONDictionary }
  }

  /// Decodes as a raw ictionary array with an optional key
  public func json(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [JSONDictionary]? {
    return try? self.json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour)
  }

  // MARK: [String: JSONObjectConvertible] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [String: T] {

    let jsonDictionary: JSONDictionary = try json(atKeyPath: keyPath)

    var result: [String: T] = [:]
    for (key, _) in jsonDictionary {
      switch invalidItemBehaviour {
      case .remove:
        result[key] = try? jsonDictionary.json(atKeyPath: key) as T
      case .throw:
        result[key] = try jsonDictionary.json(atKeyPath: key) as T
      }
    }

    return result
  }

  /// Decodes an optional dictionary
  public func json<T: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [String: T]? {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) as [String: T]
  }

  // MARK: [String: JSONRawType] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [String: T] {

    let jsonDictionary: JSONDictionary = try json(atKeyPath: keyPath)

    var result: [String: T] = [:]
    for (key, _) in jsonDictionary {
      switch invalidItemBehaviour {
      case .remove:
        result[key] = try? jsonDictionary.json(atKeyPath: key) as T
      case .throw:
        result[key] = try jsonDictionary.json(atKeyPath: key) as T
      }
    }

    return result
  }

  /// Decodes an optional dictionary
  public func json<T: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [String: T]? {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) as [String: T]
  }

  // MARK: [String: JSONPrimitiveConvertible] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [String: T] {

    let jsonDictionary: JSONDictionary = try json(atKeyPath: keyPath)

    var result: [String: T] = [:]
    for (key, _) in jsonDictionary {
      switch invalidItemBehaviour {
      case .remove:
        result[key] = try? jsonDictionary.json(atKeyPath: key) as T
      case .throw:
        result[key] = try jsonDictionary.json(atKeyPath: key) as T
      }
    }

    return result
  }

  /// Decodes an optional dictionary
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [String: T]? {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) as [String: T]
  }

  // MARK: Decodable types

  /// Decode a mandatory Decodable object
  public func json<ReturnType: JSONObjectConvertible>(atKeyPath keyPath: Key) throws -> ReturnType {
    return try ReturnType(jsonDictionary: JSONDictionaryForKey(atKeyPath: keyPath))
  }

  /// Decode an optional Decodable object
  public func json<ReturnType: JSONObjectConvertible>(atKeyPath keyPath: Key) -> ReturnType? {
    return try? ReturnType(jsonDictionary: JSONDictionaryForKey(atKeyPath: keyPath))
  }

  // MARK: [Decodable] types

  /// Decode an Array of mandatory Decodable objects
  public func json<ReturnType: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [ReturnType] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { try ($0 as? JSONDictionary).flatMap(ReturnType.init) }
  }

  /// Decode an Array of optional Decodable objects
  public func json<ReturnType: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [ReturnType]? {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour)
  }

  // MARK: RawRepresentable type

  /// Decode a mandatory RawRepresentable
  public func json<ReturnType: RawRepresentable>(atKeyPath keyPath: Key) throws -> ReturnType where ReturnType.RawValue:JSONRawType {

    guard let rawValue = self[keyPath] as? ReturnType.RawValue else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }

    guard let value = ReturnType(rawValue:rawValue) else {
      throw DecodingError.mandatoryRawRepresentableHasIncorrectValue(rawRepresentable: ReturnType.self, rawValue: rawValue)
    }

    return value
  }

  /// Decode an optional RawRepresentable
  public func json<ReturnType: RawRepresentable>(atKeyPath keyPath: Key) -> ReturnType? {
    guard let rawValue = self[keyPath] as? ReturnType.RawValue else {
      return nil
    }
    return ReturnType(rawValue:rawValue)
  }

  // MARK: [RawRepresentable] type

  /// Decode an array of custom RawRepresentable types with a mandatory key
  public func json<ReturnType: RawRepresentable>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [ReturnType] where ReturnType.RawValue:JSONRawType {

    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) {
      guard let rawValue = $0 as? ReturnType.RawValue else {
        return nil
      }
      return ReturnType(rawValue: rawValue)
    }
  }

  /// Optionally decode an array of RawRepresentable types with a mandatory key
  public func json<ReturnType: RawRepresentable>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [ReturnType]? where ReturnType.RawValue:JSONRawType {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour)
  }

  // MARK: JSONPrimitiveConvertible type

  /// Decode a custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key) throws -> T {

    guard let jsonValue = self[keyPath: keyPath] as? T.JSONType else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }

    guard let transformedValue = T.from(jsonValue: jsonValue) else {
      throw JSONPrimitiveConvertibleError.couldNotTransformJSONValue(value: jsonValue)
    }

    return transformedValue
  }

  /// Optionally decode a custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key) -> T? {

    guard let jsonValue = self[keyPath: keyPath] as? T.JSONType else {
      return nil
    }

    return T.from(jsonValue: jsonValue)
  }

  // MARK: [JSONPrimitiveConvertible] type

  /// Decode an array of custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) throws -> [T] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) {
      guard let jsonValue = $0 as? T.JSONType else {
        return nil
      }
      return T.from(jsonValue: jsonValue)
    }
  }

  /// Optionally decode an array custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove) -> [T]? {
    return try? json(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour)
  }

  // MARK: JSONDictionary and JSONArray creation

  fileprivate func JSONDictionaryForKey(atKeyPath keyPath: Key) throws -> JSONDictionary {
    guard let jsonDictionary = self[keyPath: keyPath] as? JSONDictionary else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return jsonDictionary
  }

  fileprivate func JSONArrayForKey(atKeyPath keyPath: Key) throws -> JSONArray {
    guard let jsonArray = self[keyPath: keyPath] as? JSONArray else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return jsonArray
  }

  // MARK: Array decoding

  fileprivate func decodeArray<T>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour = .remove, decodeClosure: (Any) throws -> T?) throws -> [T] {
    let jsonArray = try JSONArrayForKey(atKeyPath: keyPath)

    return try jsonArray.flatMap {
      switch invalidItemBehaviour {
      case .remove:
        guard let typedItem  = try? decodeClosure($0) else {
          return nil
        }
        return typedItem
      case .throw:
        guard let typedItem = try decodeClosure($0) else {
          throw DecodingError.incorrectType(expected: T.self, found: $0)
        }
        return typedItem
      }
    }
  }

}
