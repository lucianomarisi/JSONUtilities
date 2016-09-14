//
//  URL+JSONPrimitiveConvertible.swift
//  JSONUtilities
//
//  Created by Sam Dods on 14/09/2016.
//  Copyright © 2016 Luciano Marisi. All rights reserved.
//

import Foundation

extension URL: JSONPrimitiveConvertible {
  
  public typealias JSONType = String
  
  public static func from(jsonValue: String) -> URL? {
    return URL(string: jsonValue)
  }
  
}
