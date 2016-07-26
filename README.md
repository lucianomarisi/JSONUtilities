# JSONUtilities

[![Build Status](https://travis-ci.org/lucianomarisi/JSONUtilities.svg?branch=master)](https://travis-ci.org/lucianomarisi/JSONUtilities)
[![](https://img.shields.io/cocoapods/v/JSONUtilities.svg)](https://cocoapods.org/pods/JSONUtilities)
[![](https://img.shields.io/cocoapods/p/JSONUtilities.svg?style=flat)](https://cocoapods.org/pods/JSONUtilities)
[![codecov.io](http://codecov.io/github/lucianomarisi/JSONUtilities/coverage.svg?branch=master)](http://codecov.io/github/lucianomarisi/JSONUtilities?branch=master)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/JSONUtilities.svg?style=flat)](http://cocoadocs.org/docsets/JSONUtilities/)

Easily load JSON objects and decode them into structs or classes. The `jsonKey(_:)` function infers the type from the constant or variable definition to decode meaning no casting is needed.

- Check out the `JSONUtilitiesExample.playground` for a working example

## Installation

Either

- Use [CocoaPods](http://cocoapods.org):

	`pod 'JSONUtilities'`

OR

- Add the files inside the `JSONUtilities` folder to your project

## Types supported

### JSON raw types:

- `Int`
- `Double`
- `Float`
- `String`
- `Bool`
- `[String : AnyObject]`
- `RawRepresentable` enums

### Array of JSON raw types:

- `[Int]`
- `[Double]`
- `[Float]`
- `[String]`
- `[Bool]`
- `[[String : AnyObject]]`
- `[RawRepresentable]`

### Custom JSON objects and custom JSON object arrays

e.g. if `MyClass` and `MyStruct` conform to `Decodable` protocol

- `MyClass`
- [`MyClass`]
- `MyStruct`
- [`MyStruct`]


## Examples

Consider a JSON object that represents a person:

```json
{
  "name" : "John Doe",
  "age" : 24,
  "weight" : 72.4
}
```

### Decode JSON inline

```swift
let jsonDictionary = try JSONDictionary.fromFile("person.json")
let name: String = try jsonDictionary.jsonKey("name")
let age: Int = try jsonDictionary.jsonKey("age")
let weight: Int = try jsonDictionary.jsonKey("weight")
let profession: String? = jsonDictionary.jsonKey("profession") // Optional decoding
```

### Decode structs or classes

```swift
struct Person {

  let name : String
  let age : Int
  let weight : Double
  let profession : String?
   
  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.jsonKey("name")
    age = try jsonDictionary.jsonKey("age")
    weight = try jsonDictionary.jsonKey("weight")
    profession = jsonDictionary.jsonKey("profession")
  }
  
}
```

```swift
class Person {

  let name : String
  let age : Int
  let weight : Double
  let profession : String?

  init(name: String,
        age: Int,
     weight: Double
 profession: String?) {
    self.name = name
    self.age = age
    self.weight = weight
    self.profession = profession
  }
  
  // Need a convenience initializer on a class because Swift does not allow to throw on a designated initializer
  convenience init(jsonDictionary: JSONDictionary) throws {
    self.init(
      name : try jsonDictionary.jsonKey("name"),
      age : try jsonDictionary.jsonKey("age"),
      weight : try jsonDictionary.jsonKey("weight"),
      profession : try jsonDictionary.jsonKey("profession")
    )
  }
  
}
```

### Decode nested structs or classes by conforming to the Decodable protocol

Consider a company JSON object:

```json
{
    "name" : "Working name LTD.",
    "employees": [
        {
            "name": "John Doe",
            "age": 24,
            "weight": 72.4
        },
        {
            "name": "Jane Doe",
            "age": 22,
            "weight": 70.1
        }
    ]
}
```

The `Company` struct can decode an array of `Person` structs/classes by making `Person` conform to the `Decodable` protocol

```swift
struct Company {
  let name: String
  let employees: [Person]
  
  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.jsonKey("name")
    employees = try jsonDictionary.jsonKey("employees")
  }
}
```

### Support custom types by conforming to `Transformable`

Any type can extend the `Transformable` protocol in order to allow decoding. For example extending `NSURL`:

```swift
extension NSURL : Transformable {

  public typealias JSONType = String
  
  public static func fromJSONValue(jsonValue: String) -> Self? {
    return self.init(string: jsonValue)
  }
  
}

let urlDictionary = ["url": "www.google.com"]
let url: NSURL = try! urlDictionary.jsonKey("url") // www.google.com
```

It's also possible to have an array of `Transformable` values, for example:

```swift
let urlsDictionary = ["urls": ["www.google.com", "www.yahoo.com"]]
let urls: [NSURL] = try! urlsDictionary.jsonKey("urls") // [www.google.com, www.yahoo.com]
```
