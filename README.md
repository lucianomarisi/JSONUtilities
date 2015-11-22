# JSONUtilities

![Build Status](https://travis-ci.org/lucianomarisi/JSONUtilities.svg?branch=master)
![](https://img.shields.io/cocoapods/v/JSONUtilities.svg)

Easily load JSON objects and decode them into structs or classes

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