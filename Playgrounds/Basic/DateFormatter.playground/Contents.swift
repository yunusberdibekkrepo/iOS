import Cocoa

func timeConversion(s: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ssa"

    let date = dateFormatter.date(from: s)
    dateFormatter.dateFormat = "HH:mm:ss"

    let formattedStr = dateFormatter.string(from: date ?? .distantFuture)

    return formattedStr
}

timeConversion(s: "07:05:45PM")

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.date(from: self)
    }
}

extension Date {
    func toString(withFormat format: String = "HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }
}

print("13.03.2024 07:23".toDate(format: "dd.MM.yyyy hh:mm")?.toString())

/*
 https://www.nsdateformatter.com
 "dd": Gün (iki basamaklı)
 "MM": Ay (iki basamaklı)
 "yyyy": Yıl (dört basamaklı)
 "hh": Saat (12 saatlik format, iki basamaklı)
 "mm": Dakika (iki basamaklı)
 "a": AM/PM işareti
 */
