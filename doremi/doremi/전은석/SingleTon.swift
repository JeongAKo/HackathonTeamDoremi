//
//  SingleTon.swift
//  doremi
//
//  Created by brian은석 on 20/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import Foundation
import UIKit

class SingleTon{
    static let shared = SingleTon()
    private init() {}
    var arr :[Int] = []
    var count = 0
}
