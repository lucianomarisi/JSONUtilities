//
//  InvalidItemBehaviour.swift
//  JSONUtilities
//
//  Created by Yonas Kolb on 27/4/17.
//  Copyright © 2017 Luciano Marisi. All rights reserved.
//

import Foundation

/// The behaviour of what should be done when an invalid JSON object or primitive is found
///
/// - remove: The item is filtered, only valid items are returned
/// - fail:  The call fails. For non optional properties this will throw an error, and for optional properties nil is returned
public enum InvalidItemBehaviour<T> {
  case remove
  case fail
  case value(T)
  case custom((DecodingError) throws -> T?)

  func decodeItem(decode: () throws -> T) throws -> T? {
    switch self {
    case .remove:
      do {
         return try decode()
      } catch {
        return nil
      }
    case .fail:
      return try decode()
    case .value(let value):
      do {
        return try decode()
      } catch {
        return value
      }
    case .custom(let getValue):
      do {
        return try decode()
      } catch let error as DecodingError {
        return try getValue(error)
      }
    }
  }
}
