//
//  r.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

/**
 *  Use the Decodable protocol to support nested JSON objects
 */
public protocol Decodable {
  /**
   Creates a instance of struct or class from a JSONDictionary
   
   - parameter jsonDictionary: The JSON dictionary to parse
   
   - throws: Throws a decoding error if decoding failed
   
   - returns: A decoded instance of the type conforming to the protocol
   */
  init(jsonDictionary: JSONDictionary) throws
}

public class JSONDecoder {
  
  /// Holds the dictionary for decoding
  private let dictionary : JSONDictionary

  /**
   Designated initializer for the JSONDecoder
   
   - parameter jsonDictionary: The JSON dictionary to parse
   */
  public init(jsonDictionary: JSONDictionary) {
    self.dictionary = jsonDictionary
  }
  
  /// Decode a mandatory JSON raw type
  public func decode<T : JSONRawType>(key: String) throws -> T {

    guard let value = dictionary[key] as? T else {
      throw DecodingError.Mandatory(key: key)
    }
    return value
  }
  
  /// Decode an optional JSON raw type
  public func decode<T : JSONRawType>(key: String) -> T? {
    return dictionary[key] as? T
  }
  
  /// Decode an Array of mandatory JSON raw types
  public func decode<T>(key: String) throws -> [T] {
    guard let value = dictionary[key] as? [T] else {
      throw DecodingError.Mandatory(key: key)
    }
    return value
  }
  
  /// Decode an Array of optional JSON raw types
  public func decode<T>(key: String) -> [T]? {
    return dictionary[key] as? [T]
  }
  
  // MARK: Decodable types
  
  /// Decode an Array of mandatory Decodable objects
  public func decode<T : Decodable>(key: String) throws -> [T] {
    return decodableObjectsArray(try JSONArrayForKey(key))
  }
  
  /// Decode an Array of optional Decodable objects
  public func decode<T : Decodable>(key: String) -> [T]? {
    guard let jsonArray = try? JSONArrayForKey(key) else {
      return nil
    }
    return decodableObjectsArray(jsonArray)
  }
  
  /// Decode a mandatory Decodable object
  public func decode<T : Decodable>(key: String) throws -> T {
    return try T(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  /// Decode an optional Decodable object
  public func decode<T : Decodable>(key: String) -> T? {
    return try? T(jsonDictionary: JSONDictionaryForKey(key))
  }
  
  // MARK: JSONDictionary and JSONArray creation
  
  private func JSONDictionaryForKey(key: String) throws -> JSONDictionary {
    guard let jsonDictionary = dictionary[key] as? JSONDictionary else {
      throw DecodingError.Mandatory(key: key)
    }
    return jsonDictionary
  }
  
  private func JSONArrayForKey(key: String) throws -> JSONArray {
    guard let jsonArray = dictionary[key] as? JSONArray else {
      throw DecodingError.Mandatory(key: key)
    }
    return jsonArray
  }
  
  // MARK: JSONArray decoding
  
  private func decodableObjectsArray<T : Decodable>(jsonArray: JSONArray) -> [T] {
    var decodedArray = [T]()
    
    for jsonObject in jsonArray {
      guard let castedJsonObject = jsonObject as? JSONDictionary,
            let decodedObject = try? T(jsonDictionary: castedJsonObject) else {
              continue
      }
      decodedArray.append(decodedObject)
      }
    
    return decodedArray
  }
}