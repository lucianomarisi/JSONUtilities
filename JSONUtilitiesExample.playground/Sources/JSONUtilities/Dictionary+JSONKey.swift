//
//  Dictionary+JSONKey.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
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
public protocol StringProtocol {}
extension String: StringProtocol {}

extension Dictionary where Key: StringProtocol {
  
  // MARK: JSONRawType type
  
  /// Decode a mandatory JSON raw type
  public func jsonKey<ReturnType : JSONRawType>(key: Key) throws -> ReturnType {
    
    guard let value = self[key] as? ReturnType else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return value
  }
  
  /// Decode an optional JSON raw type
  public func jsonKey<ReturnType : JSONRawType>(key: Key) -> ReturnType? {
    return self[key] as? ReturnType
  }
  
  // MARK: [JSONRawType] type
  
  /// Decode an Array of mandatory JSON raw types
  public func jsonKey<ReturnType : JSONRawType>(key: Key) throws -> [ReturnType] {
    guard let value = self[key] as? [ReturnType] else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return value
  }
  
  /// Decode an Array of optional JSON raw types
  public func jsonKey<ReturnType : JSONRawType>(key: Key) -> [ReturnType]? {
    return self[key] as? [ReturnType]
  }
  
  // MARK: [String: AnyObject] type
  
  /// Decodes as a raw Dictionary with a mandatory key
  public func jsonKey(key: Key) throws -> JSONDictionary {
    
    guard let value = self[key] as? JSONDictionary else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return value
  }

  /// Decodes as a raw dictionary with an optional key
  public func jsonKey(key: Key) -> JSONDictionary? {
    return self[key] as? JSONDictionary
  }
  
  // MARK: [[String: AnyObject]] type
  
  /// Decodes as a raw dictionary array with a mandatory key
  public func jsonKey(key: Key) throws -> [JSONDictionary] {
    
    guard let value = self[key] as? [JSONDictionary] else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return value
  }
  
  /// Decodes as a raw ictionary array with an optional key
  public func jsonKey(key: Key) -> [JSONDictionary]? {
    return self[key] as? [JSONDictionary]
  }

  
  // MARK: Decodable types
  
  /// Decode a mandatory Decodable object
  public func jsonKey<ReturnType : Decodable>(key: Key) throws -> ReturnType {
    return try ReturnType(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  /// Decode an optional Decodable object
  public func jsonKey<ReturnType : Decodable>(key: Key) -> ReturnType? {
    return try? ReturnType(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  // MARK: [Decodable] types
  
  /// Decode an Array of mandatory Decodable objects
  public func jsonKey<ReturnType : Decodable>(key: Key) throws -> [ReturnType] {
    return decodableObjectsArray(try JSONArrayForKey(key))
  }
  
  /// Decode an Array of optional Decodable objects
  public func jsonKey<ReturnType : Decodable>(key: Key) -> [ReturnType]? {
    guard let jsonArray = try? JSONArrayForKey(key) else {
      return nil
    }
    return decodableObjectsArray(jsonArray)
  }
  
  // MARK: Transformable types
  
  /// Decode a custom raw types with a mandatory key
  public func jsonKey<TransformableType : Transformable>(key: Key) throws -> TransformableType {
    
    guard let jsonValue = self[key] as? TransformableType.JSONType else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    
    guard let transformedValue = TransformableType.fromJSONValue(jsonValue) else {
      throw TranformableError.CouldNotTransformJSONValue(value: jsonValue)
    }
    
    return transformedValue
  }
  
  /// Optionally decode a custom raw types with a mandatory key
  public func jsonKey<TransformableType : Transformable>(key: Key) -> TransformableType? {
    
    guard let jsonValue = self[key] as? TransformableType.JSONType else {
      return nil
    }
    
    return TransformableType.fromJSONValue(jsonValue)
  }
  
  // MARK: [Transformable] types
  
  /// Decode an array of custom raw types with a mandatory key
  public func jsonKey<TransformableType : Transformable>(key: Key) throws -> [TransformableType] {
    
    guard let jsonValues = self[key] as? [TransformableType.JSONType] else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    
    return jsonValues.flatMap {
      TransformableType.fromJSONValue($0)
    }

  }

  /// Optionally decode an array custom raw types with a mandatory key
  public func jsonKey<TransformableType : Transformable>(key: Key) -> [TransformableType]? {
    
    guard let jsonValues = self[key] as? [TransformableType.JSONType] else {
      return nil
    }
    
    return jsonValues.flatMap {
      TransformableType.fromJSONValue($0)
    }
    
  }
  
  // MARK: JSONDictionary and JSONArray creation
  
  private func JSONDictionaryForKey(key: Key) throws -> JSONDictionary {
    guard let jsonDictionary = self[key] as? JSONDictionary else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return jsonDictionary
  }
  
  private func JSONArrayForKey(key: Key) throws -> JSONArray {
    guard let jsonArray = self[key] as? JSONArray else {
      throw DecodingError.MandatoryKeyNotFound(key: key)
    }
    return jsonArray
  }
  
  // MARK: JSONArray decoding
  
  private func decodableObjectsArray<ReturnType : Decodable>(jsonArray: JSONArray) -> [ReturnType] {
    return jsonArray.flatMap {
      guard let castedJsonObject = $0 as? JSONDictionary else {
        return nil
      }
      
      return try? ReturnType(jsonDictionary: castedJsonObject)
    }
  }

}