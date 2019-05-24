//
//  SingleTon.swift
//  CanHearYourSheepSound
//
//  Created by Daisy on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import Foundation
import UIKit

class SingleTon{
    static let shared = SingleTon()
    private init() {}
    var arr :[Int] = []
    var count = 0
    var subtractPoint = 0
    var resultPoint = 0
}

class SingleSigle {
    static let shared = SingleSigle()
    private init() {}
    var players: [Player] = [
        Player(name: "유업", point: 10),
        Player(name: "유어비", point: 10),
        Player(name: "정아", point: 29),
        Player(name: "은석", point: 50),
        Player(name: "도영", point: 40),
        Player(name: "진배", point: 20),
        Player(name: "원표", point: 25)
    ]
}

struct Player {
    let name: String
    let point: Int
    var rank: Int
    init(name: String, point: Int, rank: Int = 0) {
        self.name = name
        self.point = point
        self.rank = rank
    }
}
