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

// Simple protocol used to extend a JSONDictionary
public protocol StringProtocol {
  func components(separatedBy: String) -> [String]
}
extension String: StringProtocol {}

extension Dictionary where Key: StringProtocol {
  
  // MARK: JSONRawType type
  
  /// Decode a mandatory JSON raw type
  public func json<ReturnType : JSONRawType>(atKeyPath keyPath: Key) throws -> ReturnType {
    
    guard let value = self[keyPath: keyPath] as? ReturnType else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return value
  }
  
  /// Decode an optional JSON raw type
  public func json<ReturnType : JSONRawType>(atKeyPath keyPath: Key) -> ReturnType? {
    return self[keyPath: keyPath] as? ReturnType
  }
  
  // MARK: [JSONRawType] type
  
  /// Decode an Array of mandatory JSON raw types
  public func json<ReturnType : JSONRawType>(atKeyPath keyPath: Key) throws -> [ReturnType] {
    guard let value = self[keyPath: keyPath] as? [ReturnType] else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return value
  }
  
  /// Decode an Array of optional JSON raw types
  public func json<ReturnType : JSONRawType>(atKeyPath keyPath: Key) -> [ReturnType]? {
    return self[keyPath: keyPath] as? [ReturnType]
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
  public func json(atKeyPath keyPath: Key) throws -> [JSONDictionary] {
    
    guard let value = self[keyPath: keyPath] as? [JSONDictionary] else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    return value
  }
  
  /// Decodes as a raw ictionary array with an optional key
  public func json(atKeyPath keyPath: Key) -> [JSONDictionary]? {
    return self[keyPath: keyPath] as? [JSONDictionary]
  }

  
  // MARK: Decodable types
  
  /// Decode a mandatory Decodable object
  public func json<ReturnType : JSONObjectConvertible>(atKeyPath keyPath: Key) throws -> ReturnType {
    return try ReturnType(jsonDictionary: JSONDictionaryForKey(atKeyPath: keyPath))
  }
  
  /// Decode an optional Decodable object
  public func json<ReturnType : JSONObjectConvertible>(atKeyPath keyPath: Key) -> ReturnType? {
    return try? ReturnType(jsonDictionary: JSONDictionaryForKey(atKeyPath: keyPath))
  }
  
  // MARK: [Decodable] types
  
  /// Decode an Array of mandatory Decodable objects
  public func json<ReturnType : JSONObjectConvertible>(atKeyPath keyPath: Key) throws -> [ReturnType] {
    return decodableObjectsArray(try JSONArrayForKey(atKeyPath: keyPath))
  }
  
  /// Decode an Array of optional Decodable objects
  public func json<ReturnType : JSONObjectConvertible>(atKeyPath keyPath: Key) -> [ReturnType]? {
    guard let jsonArray = try? JSONArrayForKey(atKeyPath: keyPath) else {
      return nil
    }
    return decodableObjectsArray(jsonArray)
  }
  
  // MARK: RawRepresentable type
  
  /// Decode a mandatory RawRepresentable
  public func json<ReturnType : RawRepresentable>(atKeyPath keyPath: Key) throws -> ReturnType where ReturnType.RawValue:JSONRawType {
    
    guard let rawValue = self[keyPath] as? ReturnType.RawValue else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    
    guard let value = ReturnType(rawValue:rawValue) else {
      throw DecodingError.mandatoryRawRepresentableHasIncorrectValue(rawRepresentable: ReturnType.self, rawValue: rawValue)
    }
    
    return value
  }
  
  /// Decode an optional RawRepresentable
  public func json<ReturnType : RawRepresentable>(atKeyPath keyPath: Key) -> ReturnType? {
    guard let rawValue = self[keyPath] as? ReturnType.RawValue else {
      return nil
    }
    return ReturnType(rawValue:rawValue)
  }
  
  
  // MARK: [RawRepresentable] type
  
  /// Decode an array of custom RawRepresentable types with a mandatory key
  public func json<ReturnType : RawRepresentable>(atKeyPath keyPath: Key) throws -> [ReturnType] where ReturnType.RawValue:JSONRawType {
    
    guard let jsonValues = self[keyPath] as? [ReturnType.RawValue] else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    
    return jsonValues.flatMap {
      ReturnType(rawValue:$0)
    }
  }
  
  /// Optionally decode an array of RawRepresentable types with a mandatory key
  public func json<ReturnType : RawRepresentable>(atKeyPath keyPath: Key) -> [ReturnType]? where ReturnType.RawValue:JSONRawType {
    
    guard let jsonValues = self[keyPath] as? [ReturnType.RawValue] else {
      return nil
    }
    
    return jsonValues.flatMap {
      ReturnType(rawValue:$0)
    }
  }
  
  // MARK: JSONPrimitiveConvertible type
  
  /// Decode a custom raw types with a mandatory key
  public func json<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(atKeyPath keyPath: Key) throws -> JSONPrimitiveConvertibleType {
    
    guard let jsonValue = self[keyPath: keyPath] as? JSONPrimitiveConvertibleType.JSONType else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    
    guard let transformedValue = JSONPrimitiveConvertibleType.from(jsonValue: jsonValue) else {
      throw JSONPrimitiveConvertibleError.couldNotTransformJSONValue(value: jsonValue)
    }
    
    return transformedValue
  }
  
  /// Optionally decode a custom raw types with a mandatory key
  public func json<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(atKeyPath keyPath: Key) -> JSONPrimitiveConvertibleType? {
    
    guard let jsonValue = self[keyPath: keyPath] as? JSONPrimitiveConvertibleType.JSONType else {
      return nil
    }
    
    return JSONPrimitiveConvertibleType.from(jsonValue: jsonValue)
  }
  
  // MARK: [JSONPrimitiveConvertible] type
  
  /// Decode an array of custom raw types with a mandatory key
  public func json<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(atKeyPath keyPath: Key) throws -> [JSONPrimitiveConvertibleType] {
    
    guard let jsonValues = self[keyPath: keyPath] as? [JSONPrimitiveConvertibleType.JSONType] else {
      throw DecodingError.mandatoryKeyNotFound(key: keyPath)
    }
    
    return jsonValues.flatMap {
      JSONPrimitiveConvertibleType.from(jsonValue: $0)
    }

  }

  /// Optionally decode an array custom raw types with a mandatory key
  public func json<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(atKeyPath keyPath: Key) -> [JSONPrimitiveConvertibleType]? {
    
    guard let jsonValues = self[keyPath: keyPath] as? [JSONPrimitiveConvertibleType.JSONType] else {
      return nil
    }
    
    return jsonValues.flatMap {
      JSONPrimitiveConvertibleType.from(jsonValue:$0)
    }
    
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
  
  // MARK: JSONArray decoding
  
  fileprivate func decodableObjectsArray<ReturnType : JSONObjectConvertible>(_ jsonArray: JSONArray) -> [ReturnType] {
    return jsonArray.flatMap {
      guard let castedJsonObject = $0 as? JSONDictionary else {
        return nil
      }
      
      return try? ReturnType(jsonDictionary: castedJsonObject)
    }
  }

}
