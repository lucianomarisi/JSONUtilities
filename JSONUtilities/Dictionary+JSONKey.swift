//
//  Dictionary+JSONKey.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

public protocol JSONRawType {}
extension Int : JSONRawType {}
extension Double : JSONRawType {}
extension Float : JSONRawType {}
extension String : JSONRawType {}
extension Bool : JSONRawType {}

extension Dictionary where Key: StringLiteralConvertible {
  
  /// Decode a mandatory JSON raw type
  public func jsonKey<ReturnType : JSONRawType>(key: Key) throws -> ReturnType {
    
    guard let value = self[key] as? ReturnType else {
      throw DecodingError.MandatoryLiteral(key: key)
    }
    return value
  }
  
  /// Decode an optional JSON raw type
  public func jsonKey<ReturnType : JSONRawType>(key: Key) -> ReturnType? {
    return self[key] as? ReturnType
  }
  
  /// Decode an Array of mandatory JSON raw types
  public func jsonKey<ReturnType>(key: Key) throws -> [ReturnType] {
    guard let value = self[key] as? [ReturnType] else {
      throw DecodingError.MandatoryLiteral(key: key)
    }
    return value
  }
  
  /// Decode an Array of optional JSON raw types
  public func jsonKey<ReturnType>(key: Key) -> [ReturnType]? {
    return self[key] as? [ReturnType]
  }
  
  // MARK: Decodable types
  
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
  
  /// Decode a mandatory Decodable object
  public func jsonKey<ReturnType : Decodable>(key: Key) throws -> ReturnType {
    return try ReturnType(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  /// Decode an optional Decodable object
  public func jsonKey<ReturnType : Decodable>(key: Key) -> ReturnType? {
    return try? ReturnType(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  // MARK: JSONDictionary and JSONArray creation
  
  private func JSONDictionaryForKey(key: Key) throws -> JSONDictionary {
    guard let jsonDictionary = self[key] as? JSONDictionary else {
      throw DecodingError.MandatoryLiteral(key: key)
    }
    return jsonDictionary
  }
  
  private func JSONArrayForKey(key: Key) throws -> JSONArray {
    guard let jsonArray = self[key] as? JSONArray else {
      throw DecodingError.MandatoryLiteral(key: key)
    }
    return jsonArray
  }
  
  // MARK: JSONArray decoding
  
  private func decodableObjectsArray<ReturnType : Decodable>(jsonArray: JSONArray) -> [ReturnType] {
    var decodedArray = [ReturnType]()
    
    for jsonObject in jsonArray {
      guard let castedJsonObject = jsonObject as? JSONDictionary,
        let jsonKeydObject = try? ReturnType(jsonDictionary: castedJsonObject) else {
          continue
      }
      decodedArray.append(jsonKeydObject)
    }
    
    return decodedArray
  }

}