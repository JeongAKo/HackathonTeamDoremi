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
    
    var saveSingleton = SingleTon.shared
    let solution = [0,2,4,0,2,4,5,5,5,4,3,3,3,2,2,2,1,1,1,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doremiAction(_ sender: UIButton) {
        act(tag: sender.tag)
        saveSingleton.arr.append(sender.tag)
        guard saveSingleton.arr.count <= solution.count else { return fail() }
        if saveSingleton.arr.last != solution[saveSingleton.arr.count - 1] {
            fail()
        } else if saveSingleton.arr.count == solution.count {
            success()
        }
    }
    
    
    @IBAction func result(_ sender: UIButton) {
        if saveSingleton.arr == solution {
           success()
        } else {
            fail()
        }
    }
    func success() {
        let alertController = UIAlertController(
            title: "성공입니다!!!", message: "점수 : \(10 - saveSingleton.count) 점" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "다음게임", style: .default) {
            _ in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondViewController")
            self.navigationController?.pushViewController(secondVC, animated: true)
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func fail() {
        saveSingleton.arr = []
        saveSingleton.count += 1
        
        let alertController = UIAlertController(
            title: "실패입니다!!!", message: "점수 : 현재 \(-saveSingleton.count)점 감점" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        saveSingleton.arr = []
        saveSingleton.count += 1
    }
    
    
    func act(tag: Int) {
        
        let url = Bundle.main.url(forResource: "dore/\(tag)", withExtension: "mp3")
        if let url = url{
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                guard let sound = soundEffect else { return }
                sound.prepareToPlay()
                sound.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
}



