import UIKit

var numbers: [Int] = [2, 4, 3, 44, 21, 467, 94, 11, 234, 6, 134, -100, 342, 34, -2]

/// Map
/// Bu fonksiyon, collection içindeki bütün elemanlara erişip her eleman için istediğimiz işlemleri uygular ve sonuç olarak yeni bir collection döner.

struct Person {
    let name: String
    let age: Int
}

var peoples: [Person] = [
    .init(name: "Yunus", age: 19),
    .init(name: "Elif", age: 12),
    .init(name: "Fatma", age: 32),
    .init(name: "Tarık", age: 45)
]

let names1 = peoples.map { $0.name }.joined(separator: "&")
print(names1)

/// Filter
/// Bu fonksiyon, verilen collection içinde belirlenen kurala göre filtreleme işlemi yapıp yeni bir collection döner.

let filteredAges1 = peoples.filter { $0.age > 19 }
print(filteredAges1.description)

/// Compact Map
/// Map fonksiyonu ile aynı işlemleri yapar. Ancak map yapma işleminde sonuç nil döner ise  collection'a eklemez.

let numbers2 = ["1", "2", "3", "q", "32", "21a"]

// Numbers dizisinde string değerleri int e dönüştürmeyi deneyelim.Bunu iki fonksiyon ile de yapacağım.

let mapNumbers2 = numbers2.map { Int($0) } // optional
print(mapNumbers2)
let compactNumbers2 = numbers2.compactMap { Int($0) } // optional değil
print(compactNumbers2)

/// FlatMap
/// Bir collection içinde farklı collectionlar var ise bunları tek bir collection olarak geri döndürür.

let countries = [["Türkiye", "Azerbaycan", "Özbekistan"], ["Rusya", "Ukrayna"], ["Almanya", "Fransa", "İngiltere", "Bolovya"]]

let countries1 = countries.flatMap { $0 }
print(countries1)

let countries2 = countries.flatMap { $0 }.map { $0.uppercased() }
print(countries2)

let sortedNumbers = numbers.sorted(by: { $0 > $1 })
print(sortedNumbers)

let sortedNumbers2 = countries.flatMap { $0 }.sorted(by: <)
print(sortedNumbers2)

numbers.sort(by: >) // Mevcut dizi üstünde sıralama yapar.
numbers.sorted(by: >) // Collection sıralayıp geri döner.
print(numbers)

/// Reduce
/// Bu fonksiyon, bir collection içindeki elemanları tek bir değere indirgemek için kullanılır.Bu fonksiyon, dizideki her eleman işlendiğinde , dizi içindeki tüm elemanların değerleri bir araya getirilir ve tek bir değer olarak döndürülür.

// first
numbers.reduce(0) { partialResult, value in
    partialResult + value
}

// second 
numbers.map { $0 }.reduce(0,+)

/// Contains
/// Bu fonksiyon, collection içinde belirli bir değerin var olup olmadığını kontrol etmek için kullanılan bir fonksiyondur.

numbers.contains(where: { $0 == 21 })

/// Foreach
/// Bu fonksiyon, collection içindeki elemanları gezmeyi sağlar.
peoples.forEach { print($0.name) }

/// RemoveAll
/// Bu fonksiyon ile, collection içinde kurallara uyan tüm elemanları siler.
peoples.removeAll(where: { $0.age < 20 })
