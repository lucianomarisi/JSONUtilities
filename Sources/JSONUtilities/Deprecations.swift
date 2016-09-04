//
//  Deprecations.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/06/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

public extension Dictionary where Key: StringProtocol, Value: Any {
  
  @available(*, deprecated:3.0.0, renamed: "from(filename:)")
  public static func fromFile(_ filename: String) throws -> JSONDictionary {
    return try from(filename: filename)
  }
  
  @available(*, deprecated:3.0.0, renamed: "from(jsonData:)")
  public static func fromData(_ jsonData: Data) throws -> JSONDictionary {
    return try from(jsonData: jsonData)
  }
  
}

@available(*, deprecated:3.0.0, renamed: "JSONPrimitiveConvertible")
public typealias Transformable = JSONPrimitiveConvertible

@available(*, deprecated:3.0.0, renamed: "JSONObjectConvertible")
public typealias Decodable = JSONObjectConvertible
