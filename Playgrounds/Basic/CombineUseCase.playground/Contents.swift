import Combine
import Foundation
import PlaygroundSupport
import SwiftUI

PlaygroundPage.current.needsIndefiniteExecution = true

// basics

// publisher
// subscriber
// operator , map vb. Publisher'a yeni bir tip eklemek vb. İçin

// back pressure publisherdan alınan değerlerin neye dönüşeceğine karar verme.

/*
 let publisher = Just("Yunus") // Sadece bir değeri publish edip yayın hayatına son veriyor.Mesela sayfa açıldığında 1 defa bir şey göstermek istiyorsak.

 // publisher'a subs atıyorum.Publisher'dan bir değer gelince çalışıyor. receive completion ise publisher değer atamayı bitirdikten sonra çalışacak fonksiyon.
 publisher
     .map { value in
         value.count
     }
     .filter { value in
         value != 0
     }
     .sink { value in //
         print("value: \(value)")
     } receiveValue: { value in
         print(value)
     }

 // Gelecekte bir zamanda olacak. Subs olduğumuz anda değer vermeyi garanti etmiyor
 let future = Future<Int, Never> { promise in
     Task {
         try await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
         promise(.success(Int.random(in: 0 ... 10)))
     }
 }

 let cancellable = future
     .sink { _ in
         print("completed")
     } receiveValue: { value in
         print(value)
     }

  */

// built in publisher

// let cancellable = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://picsum.photos/100")!)
//    .sink { _ in
//        print("completed")
//    } receiveValue: { response in
//        print("response:\(response.data.count)")
//    }
//
// let cancellable2 = [1, 3, 5, 7, 9]
//    .publisher
//    .sink { value in
//        print(value)
//    }

// let timerCancelalble = Timer
//    .publish(every: 1.0, on: .main, in: .common)
//    .autoconnect()
//    .sink { date in
//        print(date)
//    }

// let cancellable3 = NotificationCenter.default
//    .publisher(for: UIApplication.didBecomeActiveNotification) // uygulama aktif olduğunda notify
//    .sink { _ in
//    }

/// advanced concepts
// let subject = PassthroughSubject<Int, Never>() // istediğimiz zaman veri gönderebiliriz. never yerine custom error type'da gelebilir.
// subject.send(0) // burada subsriber bu değeri almaz.
// let cancellable = subject
//    .sink { _ in
//        print("completed")
//    } receiveValue: { value in
//        print(value)
//    }
//
// subject.send(5)
// subject.send(6)
// subject.send(completion: .finished)
//
// let currentSubject = CurrentValueSubject<Int, Never>(-1) // ilk değeri -1 olan pass through subject gibi değerleri publish eden publisher. Subsribe olduğum anda o anki değerinde publish ediyor.
//
// currentSubject.send(0) // burada subsriber bu değeri alır.
// let cancellable2 = subject
//    .sink { _ in
//        print("completed")
//    } receiveValue: { value in
//        print(value)
//    }
//
// currentSubject.send(completion: .finished)

/// receive on mantığı

// let cancellable = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://picsum.photos/100")!)
//    .receive(on: DispatchQueue.main) // Mesela UI güncellemesi için main thread'a geçer.
//    .sink { _ in
//        print("completed")
//    } receiveValue: { response in
//        print("response:\(response.data.count)")
//    }

/// debounce mantığı

// let subject = PassthroughSubject<Int, Never>()
//
// let cancellable = subject
//    .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true) // son değeri veriyor gibi.
//    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // mesela textfield üstünden girilen veriyi ararken girilen karakteri sorgu olarak göndermek yerine belirli bir süre beklemej.
//    .sink { value in
//        print(value)
//    }
//
////for debounce
// Task {
//    subject.send(1)
//    try? await Task.sleep(nanoseconds: NSEC_PER_MSEC * 600)
//    subject.send(2)
//    try? await Task.sleep(nanoseconds: NSEC_PER_MSEC * 300)
//    subject.send(3)
// }
//
//// Burada ilk olarak 5'i alıyor. Daha sonra yeni bir değer gelecek mi diye 500ms bekliyor. Yeni bir değer gelmez ise kendini gelir ise yeni değeri gönderir.

// let publisher = [1, 1, 3, 5, 7, 9, 9]
//    .publisher
//    .removeDuplicates() // aynı gelen değerleri siler.
//    .dropFirst() // ilk geleni siler
////    .max()//maximum değeri bulur
//    .sink { value in
//        print(value)
//    }

// struct User: Decodable {}
//
// let cancellable = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://picsum.photos/100")!)
//    .map { $0.data }
//    .decode(type: User.self, decoder: JSONDecoder()) // gelen datayı bir nesneye decode eder.
//    .receive(on: DispatchQueue.main) // Mesela UI güncellemesi için main thread'a geçer.
//    .sink { _ in
//        print("completed")
//    } receiveValue: { response in
//        print("response:\(response)")
//    }

///// type erasure
// let result: AnyPublisher = URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://picsum.photos/100")!)
//    .map { $0.data }
//    .decode(type: User.self, decoder: JSONDecoder()) // gelen datayı bir nesneye decode eder.
//    .receive(on: DispatchQueue.main) // Mesela UI güncellemesi için main thread'a geçer.
//    .eraseToAnyPublisher()

// var cancs: Set<AnyCancellable> = [] // birden fazla cancallable değeri varsa dizi içine atılabilir.
//
// URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://picsum.photos/100")!)
//    .receive(on: DispatchQueue.main)
//    .sink { _ in
//        print("completed")
//    } receiveValue: { response in
//        print("response:\(response)")
//    }
//    .store(in: &cancs)

// cancellable.cancel() // bunu cancel etmemi sağlıyor
// cancellable.store(in: &<#T##RangeReplaceableCollection#>) //bu cancellable değerini bir yerde depolamayı sağlıyor.0

/// ımage downloader publisher'i

// https://picsum.photos/100

struct ImageDownloadPublisher: Publisher {
    typealias Output = URL
    typealias Failure = Never

    let urls: [URL]

    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, URL == S.Input {
        let subscription = ImageDownloadSubscription(urls: urls, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

class ImageDownloadSubscription<S: Subscriber>: Subscription where S.Input == URL, S.Failure == Never {
    let urls: [URL]
    var subscriber: S?

    init(urls: [URL], subscriber: S) {
        self.urls = urls
        self.subscriber = subscriber

        Task {
            await startDownloading()
        }
    }

    private func startDownloading() async {
        await withTaskGroup(of: URL?.self) { group in
            for url in urls {
                group.addTask {
                    let response = try? await URLSession.shared.data(from: url)

                    if let data = response?.0 {
                        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                        if let filePath = docDir?.appendingPathComponent(url.lastPathComponent) {
                            try? data.write(to: filePath)
                            return filePath
                        }
                    }
                    return nil
                }
            }

            for await localFileURL in group {
                subscriber?.receive(localFileURL!)
            }

            subscriber?.receive(completion: .finished)
        }
    }

    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        subscriber = nil
    }
}

let publisher = ImageDownloadPublisher(urls: [
    URL(string: "https://picsum.photos/100")!,
    URL(string: "https://picsum.photos/101")!,
])

let cancellable = publisher.sink { _ in
    print("completed")
} receiveValue: { value in
    print(value)
}

