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
public enum JSONUtilsError: ErrorType {
  case FileLoadingFailed
  case FileDeserializationFailed
  case FileNotAJSONDictionary
}

public extension Dictionary where Key: StringProtocol, Value: AnyObject {
  
  /**
   Load a JSONDictionary from a file
   
   - parameter filename: The filename of the JSON file
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  public static func fromFile(filename: String) throws -> JSONDictionary {
    return try fromFile(filename, bundle: NSBundle.mainBundle())
  }
  
  /**
   Load a JSONDictionary from a file
   
   - parameter filename: The filename of the JSON file
   - parameter bundle:   The NSBundle to be used
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  static func fromFile(filename: String, bundle: NSBundle) throws -> JSONDictionary {
    guard let jsonURL = bundle.URLForResource(filename, withExtension: "json"),
      let jsonData = NSData(contentsOfURL: jsonURL) else {
        throw JSONUtilsError.FileLoadingFailed
    }
    return try fromData(jsonData)
  }
  
  /**
   Load a JSONDictionary from a NSData object
   
   - parameter jsonData: The JSON NSData to deserialize
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  public static func fromData(jsonData: NSData) throws -> JSONDictionary {
    guard let deserializedJSON = try? NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions.MutableContainers) else {
      throw JSONUtilsError.FileDeserializationFailed
    }
    
    guard let jsonDictionary: JSONDictionary = deserializedJSON as? JSONDictionary else {
      throw JSONUtilsError.FileNotAJSONDictionary
    }
    return jsonDictionary
  }
}