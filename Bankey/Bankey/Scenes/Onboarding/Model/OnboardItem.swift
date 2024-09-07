//
//  OnboardItem.swift
//  Bankey
//
//  Created by Yunus Emre Berdibek on 7.09.2024.
//

import UIKit

struct OnboardItem {
    let image: UIImage
    let text: String

    static let items: [Self] = [
        .init(image: .delorean, text: "Bankey is faster, easier to use, and has a brandy new look and feel that will make you feel like you are back in the 80s."),
        .init(image: .thumbs, text: "Move your money around the world quickly and securely."),
        .init(image: .world, text: "Learn more at www.bankey.com")
    ]
}
