//
//  SingleSigle.swift
//  doremi
//
//  Created by Daisy on 22/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import Foundation
import UIKit

class SingleSigle {
    static let shared = SingleSigle()
    private init() {}
    var players: [Player] = [
        Player(name: "유업", point: 10),
        Player(name: "정아", point: 9),
        Player(name: "은석", point: 50),
        Player(name: "도영", point: 40),
        Player(name: "진배", point: 20),
        Player(name: "원표", point: 25)
    ]
}


struct Player {
    let name: String
    let point: Int
}



