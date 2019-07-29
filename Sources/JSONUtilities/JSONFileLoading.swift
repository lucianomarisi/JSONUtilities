//
//  JSONFileLoading.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 Luciano Marisi All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : Any]
public typealias JSONArray = [Any]

/**
 Loading .json file error
 
 - FileLoadingFailed:         The .json file URL could not be found or the file could not be loaded
 - FileDeserializationFailed: NSJSONSerialization failed to deserialize the file
 - FileNotAJSONDictionary:    The .json does not contain a JSON object (i.e [String: Any]) as a top level object
 */
public enum JSONUtilsError: Error {
  case couldNotFindFile
  case fileLoadingFailed
  case fileDeserializationFailed
  case fileNotAJSONDictionary
}

public extension Dictionary where Key: StringProtocol, Value: Any {

  /**
   Load a JSONDictionary from a file
   
   - parameter filename: The filename of the JSON file
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  static func from(filename: String, bundle: Bundle = .main) throws -> JSONDictionary {
    bundle.url(forResource: filename, withExtension: "json")
    guard let url = bundle.url(forResource: filename, withExtension: "json") else {
      throw JSONUtilsError.couldNotFindFile
    }
    return try from(url: url)
  }

  /**
   Load a JSONDictionary from a file
   
   - parameter url:      The url of the json file
   - parameter bundle:   The NSBundle to be used
   
   - throws: Throws if a JSONDictionary cannot be created from the file
   
   - returns: An initilized JSONDictionary
   */
  @discardableResult
  static func from(url: URL) throws -> JSONDictionary {
    guard let jsonData = try? Data(contentsOf: url) else {
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
  static func from(jsonData: Data) throws -> JSONDictionary {
    guard let deserializedJSON = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) else {
      throw JSONUtilsError.fileDeserializationFailed
    }

    guard let jsonDictionary: JSONDictionary = deserializedJSON as? JSONDictionary else {
      throw JSONUtilsError.fileNotAJSONDictionary
    }
    return jsonDictionary
  }
}
