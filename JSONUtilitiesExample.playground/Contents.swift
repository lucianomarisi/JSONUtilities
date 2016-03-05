
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
  
  print(company.name)
  print(company.employees.first!.age)
  
} catch {}
