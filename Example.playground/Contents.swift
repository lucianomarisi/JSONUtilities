import Foundation
import JSONUtilities

// Simple example playground to see the loading and decoding of a JSON file

struct Company {
  let name: String
  let employees: [Person]
  let referenceNumber: Int
  let owner: Person

  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.json(atKeyPath: "name")
    employees = try jsonDictionary.json(atKeyPath: "employees")
    referenceNumber = try jsonDictionary.json(atKeyPath: "attributes.reference-number")
    owner = try jsonDictionary.json(atKeyPath: "attributes.owner")
  }
}

// Nested struct
struct Person: JSONObjectConvertible {

  let name: String
  let age: Int

  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.json(atKeyPath: "name")
    age = try jsonDictionary.json(atKeyPath: "age")
  }

}

do {
  let jsonDictionary = try JSONDictionary.from(filename: "example")
  let company = try Company(jsonDictionary: jsonDictionary)
  let rawEmployees: [JSONDictionary] = try jsonDictionary.json(atKeyPath: "employees")
  print(company.name)
  print(company.employees.first!.age)
  print(company.referenceNumber)
  print(company.owner)

} catch {
  print(error)
}

class City {

  let name: String

  init(name: String) {
    self.name = name
  }

  init?(jsonDictionary: JSONDictionary) {
    do {
      name = try jsonDictionary.json(atKeyPath: "name")
    } catch {
      name = ""
      return nil
    }
  }

  convenience init(throwingJSONDictionary: JSONDictionary) throws {
    self.init(
      name : try throwingJSONDictionary.json(atKeyPath: "name")
    )
  }
}

let validRawVehicleDictionary = ["name": "London"]
let validCity = City(jsonDictionary: validRawVehicleDictionary)
print(validCity?.name)

let invalidRawVehicleDictionary = ["afe": "London"]
let invalidCity = City(jsonDictionary: invalidRawVehicleDictionary)
print(invalidCity?.name)

do {
  let invalidCity = try City(throwingJSONDictionary: invalidRawVehicleDictionary)
} catch {
  print(error)
}

enum State {
  case Normal
  case Selected
}

extension State : JSONPrimitiveConvertible {

  typealias JSONType = String

  static func from(jsonValue: String) -> State? {
    switch jsonValue.lowercased() {
    case "normal":
      return .Normal
    case "selected":
      return.Selected
    default:
      return nil
    }

  }

}

let jsonDictionary = ["state": "normal", "states": ["normal", "selected"]] as [String : Any]
let stateNormal: State = try! jsonDictionary.json(atKeyPath: "state")
let multipleStates: [State] = try! jsonDictionary.json(atKeyPath: "states")

let urlDictionary = ["url": "www.google.com"]
let url: URL = try! urlDictionary.json(atKeyPath: "url") // www.google.com
let urlsDictionary = ["urls": ["www.google.com", "www.yahoo.com"]]
let urls: [URL] = try! urlsDictionary.json(atKeyPath: "urls") // [www.google.com, www.yahoo.com]

let rawDictionary: JSONDictionary = ["rootKey":
  [
    "stringKey": "value",
    "numberKey": 1
  ]
]

let decodedRawDictionary: JSONDictionary = try rawDictionary.json(atKeyPath: "rootKey")
