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

public extension Dictionary where Key: StringProtocol {
  
  // MARK: JSONRawType type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) throws -> ReturnType {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) -> ReturnType? {
    return json(atKeyPath: key)
  }
  
  // MARK: [JSONRawType] type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) throws -> [ReturnType] {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) -> [ReturnType]? {
    return json(atKeyPath: key)
  }
  
  // MARK: [String: Any] type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey(_ key: Key) throws -> JSONDictionary {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey(_ key: Key) -> JSONDictionary? {
    return json(atKeyPath: key)
  }
  
  // MARK: [[String: Any]] type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey(_ key: Key) throws -> [JSONDictionary] {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey(_ key: Key) -> [JSONDictionary]? {
    return json(atKeyPath: key)
  }
  
  // MARK: Decodable types
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) throws -> ReturnType {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) -> ReturnType? {
    return json(atKeyPath: key)
  }
  
  // MARK: [Decodable] types
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) throws -> [ReturnType] {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) -> [ReturnType]? {
    return json(atKeyPath: key)
  }
  
  // MARK: RawRepresentable type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) throws -> ReturnType where ReturnType.RawValue:JSONRawType {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) -> ReturnType? {
    return json(atKeyPath: key)
  }
  
  // MARK: [RawRepresentable] type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) throws -> [ReturnType] where ReturnType.RawValue:JSONRawType {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) -> [ReturnType]? where ReturnType.RawValue:JSONRawType {
    return json(atKeyPath: key)
  }
  
  // MARK: JSONPrimitiveConvertible type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) throws -> JSONPrimitiveConvertibleType {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) -> JSONPrimitiveConvertibleType? {
    return json(atKeyPath: key)
  }
  
  // MARK: [JSONPrimitiveConvertible] type
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) throws -> [JSONPrimitiveConvertibleType] {
    return try json(atKeyPath: key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "json(atKeyPath:)")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) -> [JSONPrimitiveConvertibleType]? {
    return json(atKeyPath: key)
  }
  
  
}

@available(*, deprecated:3.0.0, renamed: "JSONPrimitiveConvertible")
public typealias Transformable = JSONPrimitiveConvertible

@available(*, deprecated:3.0.0, renamed: "JSONObjectConvertible")
public typealias Decodable = JSONObjectConvertible
