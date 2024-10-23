import UIKit

var greeting = "Hello, playground"

// String
let quote = """
Then he tapped a sign saying \"Believe\" and walked away."
"""

/// Belirtilen string bu ifade ile mi başlıyor.
print(quote.hasPrefix("Then"))

/// Belirtilen string bu ifade ile mi bitiyor.
print(greeting.hasSuffix("playground"))

// Whole numbers

let bigNumber = 100_000_000
/// or
let bigNumber2 = 100_000_000 /// Bu şekilde yukarıdaki sayı daha kolay anlaşılabilir.Bu bizim anlamamız açısından yararlıdır.

let bigNumber3 = 100_000_000 /// Bu şekilde yukarıdaki sayı daha kolay anlaşılabilir.Bu bizim anlamamız açısından yararlıdır.

let number = 9
print(number.isMultiple(of: 2)) /// Verilen sayı parametredeki tam  bölünüyor mu
/// or
print(9.isMultiple(of: 3))
