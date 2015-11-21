//
//  JSONDecoder.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

/**
 Decoding error for mandatory keys
 
 - Mandatory: The key that failed the decoding
 */
public enum DecodingError: ErrorType {
  case Mandatory(key: String)
  
  var description: String {
    switch self {
    case .Mandatory(let key):
      return "ParseError: \(key)"
    }
  }
}

public protocol JSONRawType {}
extension String : JSONRawType {}
extension Int : JSONRawType {}
extension Double : JSONRawType {}
extension Bool : JSONRawType {}
extension Array : JSONRawType {}

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
  
  /// Holds the dictionary for decoded
  let dictionary : JSONDictionary
  
  /**
   Designated initializer for the JSONDecoder
   
   - parameter jsonDictionary: The JSON dictionary to parse
   
   - returns: An instatiated JSONDecoder
   */
  public init(jsonDictionary: JSONDictionary) {
    self.dictionary = jsonDictionary
  }
  
  /**
   Decodes a mandatory JSON value
   
   - parameter key: The JSON key
   
   - throws: A decoding error if the key is not found
   
   - returns: The decoded value from the inferred type
   */
  public func decode<T : JSONRawType>(key: String) throws -> T {
    guard let value = dictionary[key] as? T else {
      throw DecodingError.Mandatory(key: key)
    }
    return value
  }
  
  /**
   Decodes an optional JSON value
   
   - parameter key: The JSON key
   
   - returns: The decoded object from the inferred type if it exists otherwise nil
   */
  public func decode<T : JSONRawType>(key: String) -> T? {
    return dictionary[key] as? T
  }
  
  /**
   Decode a Decodable struct or class
   
   - parameter key: The JSON key
   
   - throws: A decoding error if the key is not found
   
   - returns: The decoded object from the inferred type
   */
  public func decode<T : Decodable>(key: String) throws -> T {
    
    guard let jsonDictionary = dictionary[key] as? JSONDictionary else {
      throw DecodingError.Mandatory(key: key)
    }
    return try T(jsonDictionary: jsonDictionary)
  }
}