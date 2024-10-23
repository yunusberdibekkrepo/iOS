import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

// GCD = GrandCentralDispatch

// Serial vs Concurrent

// Serial: Kendisine sadece bir işlem verebilirsin. Ve bu işlemi bitirmeden diğer işlemlere başlamaz.
// Concurrent: Kendisine aynı anda birden fazla işlem verebiliriz ve bunların çalışma zamanları önemsizdir.

DispatchQueue.main // Serial, İşlemleri main thread'a dispatch eder.Qos yoktur(işlemlerin ne kadar öncelikli olduğunu söyler).Serial queue içinde çalıştırılan kodlar çağrıldığı thread için çağrılırlar(main hariç).

DispatchQueue.global() // Concurrent, İşlemleri background thread'de sıraya koyarız. Qos vardır. Qos işlemlerin öncelik sıralarını belirler.
DispatchQueue.global(qos: .userInitiated) // userInitiated ve userInteractive qos'lar daha önceliklidir.Background qos bu işlemi yap ama uygun bir zaman bulursan yap.Benim için cok'da önemli değil manasına gelmektedir. Thread pool vardır.Oradan seçilir.

// MARK: - SERIAL

/*
 // Serial: Serial'de ise queuya bir şey ekliyor. Eğer var ise o işlemi bitirdikten sonra diğer işleme geçiyor.

 print("a")
 DispatchQueue.main.async { // Main dispatch kuyruğuna  bu işlemi ekle ve müsait olduğunda(kuyruktaki diğer işlemler tamamlanıp sıra bana geldiğinde ) herhangi bir dönüş işlemi beklemeden işlemi yap.
     // update ui label's text.
     print("b")
 }

 print("c")

 // (Serial bir kuyruk'a)Main kuyruk'a sync bir işlem verdiğimizde ama o kuyrukta zaten bir işlem var ise deadlock oluşur. Sync olunca q
 let deger1 = DispatchQueue.main.sync { // Sync olunca kuyruktan bir cevap bekliyoruz. Yani kod bloğunu bitirmeden aşşağıya geçme diyoruz. Genelde bir değere ihtiyacımız varsa kullanılır.
     print("d")
     return 5
 }

 print(deger1)
 */

// MARK: - CONCURRENT

/*
 // Concurrent (global queue): işlemler queue'ya eklendiğinde sıralı çağrılacak diye bir şey yok yani.1,2,3 eklendiğinde 1 , 2 ve 3 den önce çalışacak diye bir durum yok.2'i çalıştırmak için 1'in bitmesini beklemiyor.

 DispatchQueue.global(qos: .default).async { // Concurrent içinde queue içine ilk eklenen ilk çalışır.
     print("a")
 }

 DispatchQueue.global(qos: .default).sync {
     print("b ")
 }

 DispatchQueue.main.async {
     print("a")
 }

 DispatchQueue.main.async {
     print("a")
 }

 DispatchQueue.main.async {
     print("a")
 }

 DispatchQueue.global().async(flags: .barrier) { // Elimizde bir concurrent  queue  olsun. Bu işlem o kadar önemli ki bu queue'ya başka bir async işlem in gelip bir şeyler yapmasını istemiyoruz.Flag bu durumda kullanılır.Bir bloğu .barrier ile çağırmış isek diğer async çağrıları burası bitmeden gerçekleşmiyecek. Serial queue'lar için anlamsızdır. Öncelikli işlemlerde kullanılır.
     print("a")
 }

 // DispatchQueue.global(qos: .default).sync { // Bir queue içinde farkında olmadan birden fazla sync işlemi çağrılırsa deadlock oluşur.Dikkatli olmak gerekir.
 //    DispatchQueue.global(qos: .default).sync {}
 // }

 */

// MARK: - CUSTOM QUEUE

/*
 let serialQueue = DispatchQueue(label: "com.yunusberdibekk.App") // label vermenin amacı log'larda ve crash'larde çıktıyı görmek. Default olarak serial bir queue oluşturur.(Main queue gibi.)

 serialQueue.async {}

 let result = serialQueue.sync {
     5
 }

 let concurrentQueue = DispatchQueue(label: "com.yunusberdibekk.concurrent.App", attributes: .concurrent) // Attributes ile concurrent queue oluşturulur.

 */
