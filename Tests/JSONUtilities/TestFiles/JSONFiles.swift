//
//  JSONFiles.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 21/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

struct JSONFilename {
  static let correct = "correct"
  static let missing = "missing"
}

struct JSONFilePath {
  static let correct = "correct".filePath
  static let empty = "empty".filePath
  static let correctWithoutNested = "correct_without_nested_object".filePath
  static let correctWithoutNestedArray = "correct_with_missing_nested_array".filePath
  static let correctWithoutRawArray = "correct_with_missing_raw_array".filePath
  static let missing = "missing".filePath
  static let invalid = "invalid".filePath
  static let rootArray = "root_array".filePath
}

private extension String {
  var filePath: URL {
    let parentPath = (#file).components(separatedBy: "/").dropLast().joined(separator: "/")
    return URL(string: "file://\(parentPath)/\(self).json")!
  }
}
