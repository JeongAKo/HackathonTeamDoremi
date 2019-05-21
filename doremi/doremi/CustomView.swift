//
//  CustomView.swift
//  doremi
//
//  Created by brian은석 on 21/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class CustomView: UIView {

  let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeView() {
        let arr = [imageView,label]
        for x in arr {
            self.addSubview(x)
            x.translatesAutoresizingMaskIntoConstraints = false
        }
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

//        label
        
    }
    func content() {
        imageView.image = UIImage(named: "ballon")
    }

}

