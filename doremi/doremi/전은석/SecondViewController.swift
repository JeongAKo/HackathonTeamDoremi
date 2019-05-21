//
//  SecondViewController.swift
//  doremi
//
//  Created by brian은석 on 20/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    @IBOutlet weak var imageVeiw: UIImageView!
    @IBOutlet weak var ballonImageView: UIImageView!
    @IBOutlet var wolfImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var exbutton: UIButton!
    var arr :[UIButton] = []
    var saveNum: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    
    // 도우미 대사 함수
    func animate() {
        let str = "안녕하세요 저는 도우미입니다. 저를 클릭하시면 'Hint'를 드릴꺼에요. [참고] 양이 도레미 버튼입니다."
        for x in str {
            label.text! += "\(x)"
            RunLoop.current.run(until: Date()+0.1)
        }
    }
    
    // 힌트 함수 ( 랜덤 번호 생성하는데, 이미 생성한 번호 있으면 다시 불러와서 겹치지 않게 함)
    func randomNum() {
        let random = Int.random(in: 0...6)
        if !saveNum.contains(random) {
             saveNum.append(random)
            switch random {
            case 0:
                arr[random].setTitle("도", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            case 1:
                arr[random].setTitle("레", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            case 2:
                arr[random].setTitle("미", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            case 3:
                arr[random].setTitle("파", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            case 4:
                arr[random].setTitle("솔", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            case 5:
                arr[random].setTitle("라", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            default:
                arr[random].setTitle("시", for: .normal)
                arr[random].setTitleColor(.black, for: .normal)
            }
        } else {
            randomNum()
        }
    }
    
    
    @IBAction func infoButton(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: "무엇을 도와 드릴까요?", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "힌트(점수 -1 감점)", style: .default) {
            _ in
            // 점수 감점 하기위한 싱글톤 필요
            self.randomNum()
        }
        let cancelAction = UIAlertAction(title: "스스로 하기", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    func makeView() {
        for x in (0...6) {
            let button = UIButton()
            button.tag = x
            button.frame = CGRect(x: view.center.x - 40, y: 700, width: 80, height: 80)
            button.setImage(UIImage(named: "sheep"), for: .normal)
            button.addTarget(self, action: #selector(act(_:)), for: .touchUpInside)
            imageVeiw.addSubview(button)
            //이미지 뷰위에서는 선택 안됨. 그래서 밑에 코드 써야 됨..!!!
            imageVeiw.isUserInteractionEnabled = true
            arr.append(button)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "시작하기", style: .plain, target: self, action: #selector(start(_:)))
        
        
    }
    
    @objc func act(_ sender:UIButton) {
        print(sender)
        let url = Bundle.main.url(forResource: "dore/\(sender.tag)", withExtension: "mp3")
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
    
    
    
    
    //시작 버튼
    @IBAction func ex(_ sender: UIButton) {
        ballonImageView.isHidden = false
        label.isHidden = false
        label.text = ""
        animate()
        self.ballonImageView.isHidden = true
        self.label.isHidden = true
        
        UIView.animate(withDuration: 60, delay: 3, options: [], animations: {
            self.wolfImage.frame = CGRect(x: 0, y: 111, width: 50, height: 50)
        })

        let pointers :[CGPoint] = [CGPoint(x: view.frame.minX + 25,y: 440),CGPoint(x: 335, y: 440),CGPoint(x: 100, y: 530),CGPoint(x: 265, y: 530),CGPoint(x:view.center.x - 40 , y: 610),CGPoint(x: view.frame.minX + 25, y: 700),CGPoint(x: 335, y: 700)].shuffled()

        for x in 0...6 {
            arr[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
        }
        
        
        
    }
    
    
    @objc func start(_ sender: Any) {
        animate()
        
        let pointers :[CGPoint] = [CGPoint(x: view.frame.minX + 25,y: 440),CGPoint(x: 335, y: 440),CGPoint(x: 100, y: 530),CGPoint(x: 265, y: 530),CGPoint(x:view.center.x - 40 , y: 610),CGPoint(x: view.frame.minX + 25, y: 700),CGPoint(x: 335, y: 700)].shuffled()
        for x in 0...6 {
            arr[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
        }
    }
    
    
    
    
}
