//
//  ViewController.swift
//  doremi
//
//  Created by brian은석 on 20/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import AVFoundation


var soundEffect: AVAudioPlayer?

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doremiAction(_ sender: UIButton) {
        a(tag: sender.tag)
    }

    
    
    func a(tag: Int) {
        
        let url = Bundle.main.url(forResource: "dore/\(tag)", withExtension: "mp3")
        if let url = url{
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                guard let sound = soundEffect else { return }
                print("success")
                sound.prepareToPlay()
                sound.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
}



