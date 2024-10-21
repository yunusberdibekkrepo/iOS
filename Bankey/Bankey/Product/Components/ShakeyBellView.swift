//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 20.10.2024.
//

import UIKit

final class ShakeyBellView: UIView {
    let imageView = UIImageView()

    let buttonView: UIButton = .init()

    let buttonHeight: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakeyBellView {
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemRed
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonView.layer.cornerRadius = buttonHeight / 2
        buttonView.setTitle("9", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
    }

    func layout() {
        addSubview(imageView)
        addSubview(buttonView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),

        ])

        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            buttonView.widthAnchor.constraint(equalToConstant: 16),
            buttonView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}

// MARK: - Actions

extension ShakeyBellView {
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        // .pi/8 = 22.5 degrees
        shakeWith(duration: 1.0, angle: .pi / 8, yOffset: 0.0)
    }

    /*
     What Is A frame? #
     A collection of the view’s frame changes/ transitions, from the start state to the final state, is defined as animation and each position of the view during the animation is called as a frame.

     animateKeyframes #
     This API provides a way to design the animation in such a way that you can define multiple animations with different timings and transitions. Post this, the API simply integrates all the animations into one seamless experience.

     Let’s say that we want to move our button on the screen in a random fashion. Let’s see how we can use the keyframe animation API to do so.
     */

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1 / numberOfFrames)

        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

        UIView.animateKeyframes(
            withDuration: duration, delay: 0, options: [],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform(rotationAngle: -angle) // left
                }
                UIView.addKeyframe(withRelativeStartTime: frameDuration,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform(rotationAngle: +angle) // right
                }
                UIView.addKeyframe(withRelativeStartTime: frameDuration * 2,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform(rotationAngle: -angle) // left
                }
                UIView.addKeyframe(withRelativeStartTime: frameDuration * 3,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform(rotationAngle: +angle) // right
                }
                UIView.addKeyframe(withRelativeStartTime: frameDuration * 4,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
                }
                UIView.addKeyframe(withRelativeStartTime: frameDuration * 5,
                                   relativeDuration: frameDuration)
                {
                    self.imageView.transform = CGAffineTransform.identity
                }
            },
            completion: nil)
    }
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }

    /*
     setAnchorPoint metodunun animasyona katkısı, animasyon sırasında view’un dönüş (rotation) noktasını değiştirmesidir. Bu metod, view’un dönme ve animasyon merkezini (yani anchor point) ayarlayarak animasyonun görünümünü ve davranışını etkiler. Varsayılan olarak, bir view’un anchorPoint değeri (0.5, 0.5)‘dir, yani dönüş merkezi view’un tam ortasıdır. Ancak setAnchorPoint metodunu kullanarak bu noktayı değiştirebiliriz.

     setAnchorPoint Metodunun Katkısı

     setAnchorPoint metodunu kullanarak, view’un dönme merkezini animasyon sırasında değiştirmek şu şekilde katkı sağlar:

         1.    Dönme Noktasının Değiştirilmesi:
         •    setAnchorPoint ile anchorPoint değerini (0.5, yOffset) olarak ayarlıyorsunuz. Bu, view’un yatay eksende (x ekseni boyunca) tam ortadan döneceği, ancak dikey eksende (y ekseni boyunca) yOffset değeri ile belirlenen bir noktadan döneceği anlamına gelir.
         •    Örneğin, yOffset değeri 0.0 olarak ayarlanırsa, dönüş hareketi view’un üst kenarına yakın bir noktadan başlar. 0.5 ise tam ortadan döner. Bu, animasyonun nasıl göründüğünü ve dönüşün hangi eksende olacağını değiştirir.
         2.    Daha Doğal Bir Sallanma Efekti:
         •    Bu metod, sallanma hareketi sırasında view’un hangi nokta etrafında döneceğini belirlediği için animasyonun doğal görünmesine yardımcı olur. Örneğin, bir zil (bell) ikonu sallanıyorsa, bu ikonun üst noktasından sallanması, fiziksel olarak daha doğal görünebilir. Bu durumda yOffset değeri 0.0 gibi bir değer verilir.
         •    yOffset‘in değeri arttıkça view’un dönüş noktası aşağıya doğru kayar ve sallanma hareketi farklı bir görünüm kazanır.

     setAnchorPoint Kullanılmadığında Ne Olur?

         •    Eğer setAnchorPoint kullanılmazsa, view varsayılan olarak (0.5, 0.5) noktasından, yani tam ortasından döner.
         •    Sallanma animasyonunda bu, sanki view’un merkezinden dönüyormuş gibi bir etki oluşturur. Bu da bazı durumlarda, örneğin bir zil veya bir banner sallanıyormuş gibi doğal bir görünüm oluşturmak istediğimizde, istenilen etkiyi vermeyebilir.

     Özet

     setAnchorPoint, animasyon sırasında view’un dönüş noktasını belirleyerek, sallanma veya döndürme efektinin görsel merkezini değiştirir. Bu da animasyonun daha doğal ve istenen şekilde görünmesini sağlar. Özellikle yOffset kullanımı ile, view’un üst, orta veya alt noktalarından döndürme işlemi gerçekleştirilerek farklı görsel etkiler elde edilebilir.
     */
}
