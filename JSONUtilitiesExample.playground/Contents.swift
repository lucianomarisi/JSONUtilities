import Foundation

// Simple example playground to see the loading and decoding of a JSON file

struct Company {
  let name : String
  let employees : [Person]
  
  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.jsonKey("name")
    employees = try jsonDictionary.jsonKey("employees")
  }
}

// Nested struct
struct Person : Decodable {
  
  let name : String
  let age : Int
  
  init(jsonDictionary: JSONDictionary) throws {
    name = try jsonDictionary.jsonKey("name")
    age = try jsonDictionary.jsonKey("age")
  }
  
}

do {
  let jsonDictionary = try JSONDictionary.fromFile("example")
  let company = try Company(jsonDictionary: jsonDictionary)
  let rawEmployees : [JSONDictionary] = try jsonDictionary.jsonKey("employees")
  print(company.name)
  print(company.employees.first!.age)
  
} catch {}


class City {
  
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  init?(jsonDictionary: JSONDictionary) {
    do {
      name = try jsonDictionary.jsonKey("name")
    } catch {
      name = ""
      return nil
    }
  }
  
  convenience init(throwingJSONDictionary: JSONDictionary) throws {
    self.init(
      name : try throwingJSONDictionary.jsonKey("name")
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

extension State : Transformable {

  typealias JSONType = String
  
  static func fromJSONValue(jsonValue: String) -> State? {
    switch jsonValue.lowercaseString {
    case "normal":
      return .Normal
    case "selected":
      return.Selected
    default:
      return nil
    }
    
  }
  
}
let jsonDictionary = ["state": "normal", "states": ["normal", "selected"]]
let stateNormal: State = try! jsonDictionary.jsonKey("state")
let multipleStates : [State] = try! jsonDictionary.jsonKey("states")


extension NSURL : Transformable {
  public typealias JSONType = String
  
  public static func fromJSONValue(jsonValue: String) -> Self? {
    return self.init(string: jsonValue)
  }
  
}
let urlDictionary = ["url": "www.google.com"]
let url: NSURL = try! urlDictionary.jsonKey("url") // www.google.com
let urlsDictionary = ["urls": ["www.google.com", "www.yahoo.com"]]
let urls: [NSURL] = try! urlsDictionary.jsonKey("urls") // [www.google.com, www.yahoo.com]


let rawDictionary : JSONDictionary = ["rootKey":
  [
    "stringKey": "value",
    "numberKey": 1
  ]
]

let decodedRawDictionary : JSONDictionary = try rawDictionary.jsonKey("rootKey")


