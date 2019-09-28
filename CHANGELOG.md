# Change Log

## 6.0.1

- Fixed throwing issue 

## 6.0.0

- Migrated to Swift 5


## 5.0.0

- Migrated to Swift 4

## 4.0.0

- Decoded typed dictionaries now filter out invalid objects by default instead of failing the whole response. This aligns with the defaults of how arrays are decoded.
- Typed dictionaries and array functions now allow for specifiying the behaviour of when a child item encounters an error. See [InvalidItemBehaviour](Readme.md#InvalidItemBehaviour) for more details. The default is to remove these child items with `.remove`
- DecodingError has been restructured, so that every error provides:
	- dictionary
	- keypath
	- expectedType
	- value
	- optional array if the error occured within an array
- Each DecodingError type has also been moved into a simple reason enum. JSONPrimitiveConvertibleError has also been merged into DecodingError, which now as the following error reasons:
	- keyNotFound
	- incorrectRawRepresentableRawValue
	- incorrectType
	- conversionFailure
- `[String: RawRepresentable]` can be now be decoded

Thanks to [Yonas Kolb](https://github.com/yonaskolb)

## 3.2.0

- This adds support for decoding typed dictionaries with a String key, specifically:
	- `[String: JSONRawType]`
	- `[String: JSONObjectConvertible]`
	- `[String: JSONPrimitiveConvertible]`

Thanks to [Yonas Kolb](https://github.com/yonaskolb)

## 3.1.0

- Added support for `URL` decoding out of the box thanks to [Sam Dods](https://github.com/samdods)

## 3.0.0

## New Features
- Support for Swift 3
- Keypath access in JSON dictionaries

## API updates
- Renamed function for accessing values `jsonKey(_:)` to `json(atKeyPath:)`
- Renamed `Transformable` protocol to `JSONPrimitiveConvertible`
- Renamed `Decodable` protocol to `JSONObjectConvertible`
- Renamed JSONDictionary loading functions:
	-  `fromFile(_:)` to `from(filename:)`
	-  `fromData(_:)` to `from(jsonData:)`

## 2.5.0

- Added suppport for decoding arrays of `RawRepresentable` enums, i.e. `[RawRepresentable]`

## 2.4.0

- Added suppport for `RawRepresentable` enums thanks to Yonas Kolb

## 2.3.0

- Added support for decoding an array of `Tranformable` values

## 2.2.0

- Added support for decoding a raw JSON dictionary and an array of raw JSON dictionary, i.e. `[String : AnyObject]` and `[[String : AnyObject]]`

## 2.1.0

- Added `Tranformable` protocol to support decoding for custom types

## 2.0.1

- Renamed `MandatoryLiteral` enum in `DecodingError` to `MandatoryKeyNotFound` for clarity

## 2.0.0

- API now uses a functional approach.
- `JSONDecoder` class and its associated methods have been replaced by an `extension` on `Dictionary`. The JSON key is now decoded by calling the `jsonKey(_:)` function. e.g.:

```swift
let jsonDictionary = [
  "key": "value",
  "key2": "value2"
]

let myStringValue : String? = jsonDictionary.jsonKey("key")
print(myStringValue) // "Optional("value")\n"
```