
// Simple example playground to see the loading and decoding of a JSON file

struct Company {
  let name : String
  let employees : [Person]
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    name = try decoder.decode("name")
    employees = try decoder.decode("employees")
  }
}

// Nested struct
struct Person : Decodable {
  
  let name : String
  let age : Int
  
  init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    name = try decoder.decode("name")
    age = try decoder.decode("age")
  }
  
}

do {
  let jsonDictionary = try JSONDictionary.fromFile("example")
  let company = try Company(jsonDictionary: jsonDictionary)
  
  print(company.name)
  print(company.employees.first!.age)
  
} catch {}