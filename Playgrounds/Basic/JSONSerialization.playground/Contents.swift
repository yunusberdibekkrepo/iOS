import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - JSON Serialization, JSON: JavaScript Object Notation

// [String:Any]
let jsonExample = """
{
    "name":"Yunus",
    "surname":"Berdibek",
    "age":22
}
""".data(using: .utf8)!

do {
    let resultExample = try JSONSerialization.jsonObject(with: jsonExample, options: .mutableContainers) as! [String: Any]

    if let name = resultExample["name"] as? String,
       let surname = resultExample["surname"] as? String,
       let age = resultExample["age"] as? Int
    {
        print(name + surname + age.description)
    }
}

// as? downcasting
// as! upcasting
