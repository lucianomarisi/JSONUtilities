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
public enum DecodingError<KeyType: StringLiteralConvertible>: ErrorType {
  case MandatoryKeyNotFound(key: KeyType)
  
  public var description: String {
    switch self {
    case .MandatoryKeyNotFound(let key):
      return "ParseError: \(key)"
    }
    
  }
}