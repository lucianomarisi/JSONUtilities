//
//  Decodable.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
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