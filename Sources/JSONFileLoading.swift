//
//  JSONFileLoading.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : AnyObject]
public typealias JSONArray = [AnyObject]

/**
 Loading .json file error
 
 - FileLoadingFailed:         The .json file URL could not be found or the file could not be loaded
 - FileDeserializationFailed: NSJSONSerialization failed to deserialize the file
 - FileNotAJSONDictionary:    The .json does not contain a JSON object (i.e [String: AnyObject]) as a top level object
 */
public enum JSONUtilsError: ErrorProtocol {
  case fileLoadingFailed
  case fileDeserializationFailed
  case fileNotAJSONDictionary
}

public extension Dictionary where Key: StringProtocol, Value: AnyObject {
  
  /**
   Load a JSONDictionary from a file
   
   - parameter filename: The filename of the JSON file
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  public static func from(filename: String) throws -> JSONDictionary {
    return try from(filename: filename, bundle: .main)
  }
  
  /**
   Load a JSONDictionary from a file
   
   - parameter filename: The filename of the JSON file
   - parameter bundle:   The NSBundle to be used
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  @discardableResult
  static func from(filename: String, bundle: Bundle) throws -> JSONDictionary {
    guard let jsonURL = bundle.urlForResource(filename, withExtension: "json"),
      let jsonData = try? Data(contentsOf: jsonURL) else {
        throw JSONUtilsError.fileLoadingFailed
    }
    return try from(jsonData: jsonData)
  }
  
  /**
   Load a JSONDictionary from a NSData object
   
   - parameter jsonData: The JSON NSData to deserialize
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  public static func from(jsonData: Data) throws -> JSONDictionary {
    guard let deserializedJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) else {
      throw JSONUtilsError.fileDeserializationFailed
    }
    
    guard let jsonDictionary: JSONDictionary = deserializedJSON as? JSONDictionary else {
      throw JSONUtilsError.fileNotAJSONDictionary
    }
    return jsonDictionary
  }
}
