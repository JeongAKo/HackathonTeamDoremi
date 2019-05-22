//
//  ThirdViewController.swift
//  doremi
//
//  Created by brian은석 on 22/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import AVFoundation


class ThirdViewController: UIViewController {
    let backgroundImageView = UIImageView()
    let personButton = UIButton()
    let balloonLabel = UILabel()
    let balloonImageView = UIImageView()
    let wolfImageView = UIImageView()
    let startButton = UIButton()
    let kingButton = UIButton()
    
    
    var buttonArray :[UIButton] = []
    var saveNum: [Int] = []
    
    private var biggerWidthSize: NSLayoutConstraint!
    private var biggerHeightSize: NSLayoutConstraint!
    
    //싱글톤
    var saveSingleton = SingleTon.shared
    let solution = [0,2,4,0,2,4,5,5,5,4,3,3,3,2,2,2,1,1,1,0]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    
    
    
    
    func makeView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "simple")
        backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        backgroundImageView.isUserInteractionEnabled = true
        
        
        let arr = [personButton,balloonImageView,wolfImageView,startButton]
        for x in arr {
            backgroundImageView.addSubview(x)
            x.translatesAutoresizingMaskIntoConstraints = false
        }
        personButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor,constant: 260).isActive = true
        personButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        personButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        personButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        personButton.setImage(UIImage(named: "person"), for: .normal)
        personButton.addTarget(self, action: #selector(helperSelectButton(_:)), for: .touchUpInside)
        
        
        balloonImageView.image = UIImage(named: "ballon")
        balloonImageView.bottomAnchor.constraint(equalTo: personButton.topAnchor, constant: -5).isActive = true
        balloonImageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        balloonImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        balloonImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        balloonImageView.isUserInteractionEnabled = true
        
        
        balloonImageView.addSubview(balloonLabel)
        balloonLabel.translatesAutoresizingMaskIntoConstraints = false
        balloonLabel.topAnchor.constraint(equalTo: balloonImageView.topAnchor, constant: 0).isActive = true
        balloonLabel.leadingAnchor.constraint(equalTo: balloonImageView.leadingAnchor,constant: 10).isActive = true
        balloonLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        balloonLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true
        balloonLabel.text = ""
        balloonLabel.numberOfLines = 0
        
        wolfImageView.image = UIImage(named: "wolf")
        let defaultTopAnchor = wolfImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor , constant: 80)
        defaultTopAnchor.priority = UILayoutPriority(900)
        defaultTopAnchor.isActive = true
        
        let defaultLeadingAnchor = wolfImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor)
        defaultLeadingAnchor.priority = UILayoutPriority(900)
        defaultLeadingAnchor.isActive = true
        
        let defaultHeight = wolfImageView.heightAnchor.constraint(equalToConstant: 60)
        defaultHeight.priority = UILayoutPriority(900)
        defaultHeight.isActive = true
        let defaultwidth = wolfImageView.widthAnchor.constraint(equalToConstant: 50)
        defaultwidth.priority = UILayoutPriority(900)
        defaultwidth.isActive = true
        
        startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        startButton.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        startButton.layer.cornerRadius = 30
        startButton.addTarget(self, action: #selector(startInfo), for: .touchUpInside)
        startButton.setImage(UIImage(named: "sun1"), for: .normal)
        
        backgroundImageView.addSubview(kingButton)
        kingButton.frame = CGRect(x: view.frame.maxX - 40, y: backgroundImageView.frame.minY + 10, width: 20, height: 20)
        kingButton.setImage(UIImage(named: "king"), for: .normal)
        kingButton.isHidden = true
        
        
        for x in (0...6) {
            let button = UIButton()
            button.tag = x
            button.frame = CGRect(x: view.center.x - 40, y: view.frame.maxY - 260, width: 80, height: 80)
            
            button.setImage(UIImage(named: "sheep"), for: .normal)
            button.addTarget(self, action: #selector(act(_:)), for: .touchUpInside)
            button.isSelected = true
            
            backgroundImageView.addSubview(button)
            //이미지 뷰위에서는 선택 안됨. 그래서 밑에 코드 써야 됨..!!!
            buttonArray.append(button)
        }
        
        
    }
    //버튼 눌렀을때 액션들 소리나옴.
    @objc func act(_ sender:UIButton) {
        print(sender)
        saveSingleton.arr.append(sender.tag)
        
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
        sender.setImage(UIImage(named: "selected"), for: .selected)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options:[],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                                        sender.center.y -= 70
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                                        sender.center.y += 70
                                    })
                                    self.backgroundImageView.layoutIfNeeded()
        }) {_ in
            sender.setImage(UIImage(named: "sheep"), for: .selected)
        }
        
        //눌렀을 때 맞게 눌렀는지 구별해주는 가드문.
        
        guard saveSingleton.arr.count <= solution.count else { return fail() }
        if saveSingleton.arr.last != solution[saveSingleton.arr.count - 1] {
            
            fail()
            RunLoop.current.run(until: Date()+0.1)
            self.wolfImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            
            
        } else if saveSingleton.arr.count == solution.count {
            UIView.animate(withDuration: 2) {
                self.kingButton.isHidden = false
                self.wolfImageView.isHidden = true
                self.kingButton.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.kingButton.frame = CGRect(x: 90, y: 200, width: 250, height: 300)
            }
            RunLoop.current.run(until: Date()+2.1)
            
            success()
            
            
        }
        
    }
    
    // 눌렀을때 맞는지 틀린지 구별해주는 함수 두개
    func success() {
        let alertController = UIAlertController(
            title: "성공입니다!!!", message: "점수 : \(10 - saveSingleton.count) 점" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "다음게임", style: .default) {
            _ in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondViewController")
            self.show(secondVC, sender: true)
            //            self.navigationController?.pushViewController(secondVC, animated: true)
            
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
    
    
    
    @objc func startInfo() {
        startButton.isEnabled = false
        // 도우미 대사 함수
        helperInforText()
        
        //양 이동 코드
        let pointers :[CGPoint] = [
            CGPoint(x: view.frame.minX + 15,y: view.frame.maxY - 450),
            CGPoint(x: view.frame.maxX - 95, y: view.frame.maxY - 450),
            CGPoint(x: view.center.x - 120, y: view.frame.maxY - 390),
            CGPoint(x: view.center.x + 40, y: view.frame.maxY - 390),
            CGPoint(x: view.center.x - 40 , y: view.frame.maxY - 320),
            CGPoint(x: view.center.x - 120, y: view.frame.maxY - 260),
            CGPoint(x: view.center.x + 40, y: view.frame.maxY - 260)].shuffled()
        
        for x in 0...6 {
            buttonArray[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
            RunLoop.current.run(until: Date()+0.2)
        }
        
        // 늑대 이동하는 애니매이션
        UIView.animate(withDuration: 60) {
            self.wolfImageView.trailingAnchor.constraint(equalTo: self.personButton.leadingAnchor,constant: 15).isActive = true
            self.wolfImageView.centerYAnchor.constraint(equalTo: self.personButton.centerYAnchor).isActive = true
            self.wolfImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            self.wolfImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            
            self.backgroundImageView.layoutIfNeeded()
        }
        
        //해는 60초뒤에 떠야함;
        //        DispatchQueue.global().async {
        //
        //            DispatchQueue.main.async {
        //                RunLoop.current.run(until: Date()+60)
        //
        //                self.startButton.setImage(UIImage(named: "sun2"), for: .normal)
        //
        //            }
        //        }
        //
        
        //일단 말풍선 숨기고.
        balloonLabel.isHidden = true
        balloonImageView.isHidden = true
        
        
    }
    
    // 안내원 처음 시작 대사
    func helperInforText() {
        balloonLabel.isHidden = false
        balloonImageView.isHidden = false
        let str = "안"//녕하세요 저는 도우미입니다.저를 클릭하시면 'Hint'를 드릴꺼에요. [참고] 양이 도레미 버튼입니다."
        for x in str {
            balloonLabel.text! += "\(x)"
            RunLoop.current.run(until: Date()+0.1)
        }
        
    }
    
    //안내원 눌렀을 때 나오는 어럿
    @objc func helperSelectButton(_ sender: UIButton) {
        
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
    
    
    
    // 힌트 함수 ( 랜덤 번호 생성하는데, 이미 생성한 번호 있으면 다시 불러와서 겹치지 않게 함)
    func randomNum() {
        guard self.saveSingleton.arr.count <= self.solution.count else { return self.fail() }
        let random = Int.random(in: 0...6)
        if !saveNum.contains(random) {
            saveNum.append(random)
            switch random {
            case 0:
                buttonArray[random].setTitle("도", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            case 1:
                buttonArray[random].setTitle("레", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            case 2:
                buttonArray[random].setTitle("미", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            case 3:
                buttonArray[random].setTitle("파", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            case 4:
                buttonArray[random].setTitle("솔", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            case 5:
                buttonArray[random].setTitle("라", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            default:
                buttonArray[random].setTitle("시", for: .normal)
                buttonArray[random].setTitleColor(.black, for: .normal)
            }
        } else {
            randomNum()
        }
    }
    
    
}
