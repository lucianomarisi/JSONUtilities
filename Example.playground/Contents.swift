import UIKit
import JSONUtilities

extension NSURL : JSONPrimitiveConvertible {
	public typealias JSONType = String
	
	public static func from(jsonValue: String) -> Self? {
		return self.init(string: jsonValue)
	}
	
}
let urlDictionary = ["url": "www.google.com"]
let url: NSURL = try! urlDictionary.jsonKey("url") // www.google.com
