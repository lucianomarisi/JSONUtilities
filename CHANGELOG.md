# Change Log

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