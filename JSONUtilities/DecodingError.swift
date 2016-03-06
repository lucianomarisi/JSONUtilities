//
//  DecodingError.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 TechBrewers LTD. All rights reserved.
//

import Foundation

/**
 Decoding error for mandatory keys
 
 - Mandatory: The key that failed the decoding
 */
public enum DecodingError: ErrorType {
  case MandatoryKeyNotFound(key: StringLiteralConvertible)
  
  public var description: String {
    switch self {
    case .MandatoryKeyNotFound(let key):
      return "ParseError: \(key)"
    }
    
  }
}