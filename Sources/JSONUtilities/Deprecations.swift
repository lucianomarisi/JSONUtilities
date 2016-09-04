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
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) throws -> ReturnType {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) -> ReturnType? {
    return jsonKeyPath(key)
  }
  
  // MARK: [JSONRawType] type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) throws -> [ReturnType] {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONRawType>(_ key: Key) -> [ReturnType]? {
    return jsonKeyPath(key)
  }
  
  // MARK: [String: Any] type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey(_ key: Key) throws -> JSONDictionary {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey(_ key: Key) -> JSONDictionary? {
    return jsonKeyPath(key)
  }
  
  // MARK: [[String: Any]] type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey(_ key: Key) throws -> [JSONDictionary] {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey(_ key: Key) -> [JSONDictionary]? {
    return jsonKeyPath(key)
  }
  
  // MARK: Decodable types
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) throws -> ReturnType {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) -> ReturnType? {
    return jsonKeyPath(key)
  }
  
  // MARK: [Decodable] types
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) throws -> [ReturnType] {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : JSONObjectConvertible>(_ key: Key) -> [ReturnType]? {
    return jsonKeyPath(key)
  }
  
  // MARK: RawRepresentable type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) throws -> ReturnType where ReturnType.RawValue:JSONRawType {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) -> ReturnType? {
    return jsonKeyPath(key)
  }
  
  // MARK: [RawRepresentable] type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) throws -> [ReturnType] where ReturnType.RawValue:JSONRawType {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<ReturnType : RawRepresentable>(_ key: Key) -> [ReturnType]? where ReturnType.RawValue:JSONRawType {
    return jsonKeyPath(key)
  }
  
  // MARK: JSONPrimitiveConvertible type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) throws -> JSONPrimitiveConvertibleType {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) -> JSONPrimitiveConvertibleType? {
    return jsonKeyPath(key)
  }
  
  // MARK: [JSONPrimitiveConvertible] type
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) throws -> [JSONPrimitiveConvertibleType] {
    return try jsonKeyPath(key)
  }
  
  @available(*, deprecated:3.0.0, renamed: "jsonKeyPath")
  public func jsonKey<JSONPrimitiveConvertibleType : JSONPrimitiveConvertible>(_ key: Key) -> [JSONPrimitiveConvertibleType]? {
    return jsonKeyPath(key)
  }
  
  
}

@available(*, deprecated:3.0.0, renamed: "JSONPrimitiveConvertible")
public typealias Transformable = JSONPrimitiveConvertible

@available(*, deprecated:3.0.0, renamed: "JSONObjectConvertible")
public typealias Decodable = JSONObjectConvertible
