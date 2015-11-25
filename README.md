# JSONUtilities

![Build Status](https://travis-ci.org/lucianomarisi/JSONUtilities.svg?branch=master)
![](https://img.shields.io/cocoapods/v/JSONUtilities.svg)

Easily load JSON objects and decode them into structs or classes. The `JSONDecoder` infers the type from the constant or variable definition to decode meaning no casting is needed.

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

### Array of JSON raw types:

- `[Int]`
- `[Double]`
- `[Float]`
- `[String]`
- `[Bool]`

### Custom JSON objects and custom JSON object arrays

e.g. if `MyClass` and `MyStruct` conform to `Decodable` protocol

- `MyClass`
- [`MyClass`]
- `MyStruct`
- [`MyStruct`]


**Note: Raw dictionaries are intentionally not supported, i.e. `[String : T]`**


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
let personDecoder = try JSONDecoder(jsonDictionary: jsonDictionary)
let name: String = try personDecoder.decode("name")
let age: Int = try personDecoder.decode("age")
let weight: Int = try personDecoder.decode("weight")
let profession: String? = personDecoder.decode("profession") // Optional decoding
```

### Decode structs or classes

```swift
struct Person {

  let name: String
  let age: Int
  let weight: Double
  let profession: String?
   
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    name = try personDecoder.decode("name")
    age = try personDecoder.decode("age")
    weight = try personDecoder.decode("weight")
    profession = personDecoder.decode("profession")
  }
  
}
```

```swift
class Person {

  let name: String
  let age: Int
  let weight: Double
  let profession: String?

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
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    self.init(
      name : try decoder.decode("name"),
      age : try decoder.decode("age"),
      weight : try decoder.decode("weight"),
      profession : try decoder.decode("profession")
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

The `Company` struct can decode an array of `Person` structs/classes that conform to the `Decodable`

```swift
struct Company {
  let name: String
  let employees: [Person]
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    name = try decoder.decode("name")
    employees = try decoder.decode("employees")
  }
}
```