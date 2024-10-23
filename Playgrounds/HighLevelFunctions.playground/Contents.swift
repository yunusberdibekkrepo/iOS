import UIKit

// MARK: - Map

/// Use map to loop over a collection and apply the same operation to each element in collection.
/// The map function returns an array containing results of appliying a mapping or transform function to each item.

let values = [2, 3, 4, 5, 6, 7, 8, 9, 10]
let squares = values.map { $0 * $0 }

let scores = [0, 25, 1]
let words = scores.map { NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut) }

let milesToPoint = ["point1": 120.0, "point2": 50.0, "point3": 70.0]
let kmToPoint = milesToPoint.map { _, miles in miles * 1.609344 }

// MARK: - Filter

/// Use filter to loop over a collection and return an Array containing only those elements thats match an include condition.

let digits = [1, 3, 4, 57, 137]
let evenDigits = digits.filter { $0 % 2 == 0 }

// MARK: - Reduce

/// Use reduce to combine all items in a collection to create a single new value.

let items = [2.0, 4.0, 5.0, 7.0]
let total = items.reduce(10.0, +)
// 28

let codes = ["abc", "def", "ghi"]
let text = codes.reduce("", +)
// "abcdefghi"

let names = ["alan", "brian", "charlie"]
let csv = names.reduce("===") { text, name in "\(text),\(name)" }
// "===,alan,brian,charlie"

// MARK: - FlatMap and CompactMap

/// These variations on the plain map that flatten or compact result.There are three situations where they apply:
/// 1: Using FlatMap on a sequence with a closure that returns a sequence
///     Sequence.flatMap<S>(_ transform:(Element)->S) -> [S.Element] where S:Sequence
///    I think this was probably the first use of flatMap I came across in Swift. Use it to apply a closure to each element of a sequence and flatten the result:

let results = [[5, 2, 7], [4, 8], [9, 1, 3]]
let allResults = results.flatMap { $0 }
// [5, 2, 7, 4, 8, 9, 1, 3]

let passMarks = results.flatMap { $0.filter { $0 > 5 } }
// [7, 8, 9]

/// 2: Using FlatMap on an optional:
///    Optional.flatMap<U>(_ transform: (Wrapped) -> U?) -> U?

let input: Int? = Int("8")
let passMark: Int? = input.flatMap { $0 > 5 ? $0 : nil }
// 8

/// 3: Using CompactMap on a sequence with a closure that returns an optional:
///    Sequence.compactMap<U>(_ transform: (Element) -> U?) -> U?
///    Note that this use of flatMap was renamed to compactMap in Swift 4.1 (Xcode 9.3). It provides a convenient way to strip nil values from an array:

let keys: [String?] = ["Tom", nil, "Peter", nil, "Harry"]
let validNames = keys.compactMap { $0 }
validNames
// ["Tom", "Peter", "Harry"]

let counts = keys.compactMap { $0?.count }
counts
// [3, 5, 5]

// MARK: - Chaining

/// You can chain methods. For example to sum only those numbers greater than or equal to seven we can first filter and then reduce:

let marks = [4, 5, 8, 2, 9, 7]
let totalPass = marks.filter { $0 >= 7 }.reduce(0, +)
// 24

/// Another example that returns only the even squares by first filtering the odd values and then mapping the remaining values to their squares (as pointed out in the comments filtering first avoids mapping the odd values which always give odd squares):

let numbers = [20, 17, 35, 4, 12]
let evenSquares = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }
// [400, 16, 144]
