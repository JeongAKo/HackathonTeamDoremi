//
//  CustomCell.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    @IBOutlet weak var rankingNum: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var grade: UILabel!
    
}
