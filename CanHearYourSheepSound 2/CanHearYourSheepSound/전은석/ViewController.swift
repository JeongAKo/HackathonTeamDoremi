//
//  ViewController.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import AVFoundation

var soundEffect: AVAudioPlayer?

class ViewController: UIViewController {
    let backgroundImageView = UIImageView()
    let personButton = UIButton()
    let balloonLabel = UILabel()
    let balloonImageView = UIImageView()
    let wolfImageView = UIImageView()
    let startButton = UIButton()
    let kingButton = UIButton()
    let userNameLabel = UILabel()
    let infoButton = UIButton()
    
    var printResult = 0
    var recordArr: [Int] = []
    var result: [Int] = []
    var tempArray: [Int] = []
    var reversedArray: [Int] = []
    
    let dore = ["도","레","미","파","솔","라","시"]
    var labelArray :[UILabel] = []
    var buttonArray :[UIButton] = []
    var saveNum: [Int] = []
    var avatar = ""
    let userAvatar = UIImageView()
    
    private var biggerWidthSize: NSLayoutConstraint!
    private var biggerHeightSize: NSLayoutConstraint!
    
    //싱글톤
    var saveSingleton = SingleTon.shared
    let solution = [0,2,4,0,2,4,5,5,5,4,3,3,3,2,2,2,1,1,1,0]
    var autoButton :[UIButton] = []
    
    let infoVC = InforViewController()
    
    // 이미지 변경
    var count = 0
    let personImage = ["person","man"]
    let loseImage = ["wolf","people"]
    let winImage = ["king","wolf"]
    
    
    // 데이터 저장 (싱글톤)
    
    func appendData() {
        SingleSigle.shared.players.append(Player(name: userNameLabel.text!, point: printResult))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        infoVC.delegate = self
        makeRankNumber()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sheepShift()
        
    }
    func firstPerform() {
        for x in solution {
            autoButton.append(buttonArray[x])
        }
        for btn in autoButton{
            react(btn)
            RunLoop.current.run(until: Date()+0.6)
        }
    }
    //버튼 눌릴때 소린아ㅗㅁ
    
    func react(_ sender:UIButton) {
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
        sender.isSelected = true
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
            sender.isSelected = false

        }
    }
    
    
    @objc func act(_ sender:UIButton) {
        print(sender)
        saveSingleton.arr.append(sender.tag)
        
        react(sender)
        
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
    
    func makeRankNumber() {
        tempArray = SingleSigle.shared.players.map {$0.point}
        
        for str in tempArray {
            if !result.contains(str) && !recordArr.contains(str) {
                result.append(str)
                print("result: \(result)")
            } else if let index = result.firstIndex(of: str) {
                result.remove(at: index)
                result.append(str)
            }
            reversedArray = result.sorted().reversed()
        }
        
        print("result: \(result)")
        print("recordArr: \(recordArr)")
        print("reversedArray: \(reversedArray)")
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
        
        
        let arr = [personButton,balloonImageView,wolfImageView,startButton,userNameLabel,infoButton,userAvatar]
        for x in arr {
            backgroundImageView.addSubview(x)
            x.translatesAutoresizingMaskIntoConstraints = false
        }
        personButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor,constant: 260).isActive = true
        personButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        personButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        personButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //이미지 1
        personButton.setImage(UIImage(named:personImage[count]), for: .normal)
        personButton.addTarget(self, action: #selector(helperSelectButton(_:)), for: .touchUpInside)
        
        
        balloonImageView.image = UIImage(named: "ballon")
        balloonImageView.bottomAnchor.constraint(equalTo: personButton.topAnchor, constant: -5).isActive = true
        balloonImageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        balloonImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        balloonImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        balloonImageView.isUserInteractionEnabled = true
        
        
        balloonImageView.addSubview(balloonLabel)
        balloonLabel.translatesAutoresizingMaskIntoConstraints = false
        balloonLabel.topAnchor.constraint(equalTo: balloonImageView.topAnchor, constant: 0).isActive = true
        balloonLabel.leadingAnchor.constraint(equalTo: balloonImageView.leadingAnchor,constant: 10).isActive = true
        balloonLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        balloonLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        balloonLabel.text = ""
        balloonLabel.numberOfLines = 0
        
        
        // 이미지2
        wolfImageView.image = UIImage(named: loseImage[count])
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
        
        
        // 유저 네임과 유저 아바타~~~~~~
    
       
        
        userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userNameLabel.text = "유저네임 들어갈곳"
        
        userAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userAvatar.trailingAnchor.constraint(equalTo: userNameLabel.leadingAnchor).isActive = true
        userAvatar.widthAnchor.constraint(equalToConstant: 20).isActive = true
        userAvatar.heightAnchor.constraint(equalToConstant: 20).isActive = true
        userAvatar.loadGif(name: avatar)
        //~~~~~~~~~~~~~~~~
        
        
        backgroundImageView.addSubview(kingButton)
        kingButton.frame = CGRect(x: view.frame.maxX - 40, y: backgroundImageView.frame.minY + 10, width: 20, height: 20)
        
        //이미지3
        kingButton.setImage(UIImage(named: winImage[count]), for: .normal)
        kingButton.isHidden = true
        
        infoButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,constant: -20).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor,constant: -20).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        infoButton.layer.cornerRadius = 30
        infoButton.backgroundColor = .gray
        infoButton.setTitle("변경", for: .normal)
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        
        for x in (0...6) {
            let button = UIButton()
            button.tag = x
            button.frame = CGRect(x: view.center.x - 40, y: view.frame.maxY - 260, width: 80, height: 80)
            
            button.setImage(UIImage(named: "sheep"), for: .normal)
            button.addTarget(self, action: #selector(act(_:)), for: .touchUpInside)
            button.isSelected = true
            let label = UILabel()
            label.frame = CGRect(x: 40, y: 28, width: 40, height: 40)
            label.text = dore[x]
            label.tag = x
            label.isHidden = true
 //양들//////////////////////////////////
            button.isEnabled = false
            backgroundImageView.addSubview(button)
                 button.addSubview(label)
            //이미지 뷰위에서는 선택 안됨. 그래서 밑에 코드 써야 됨..!!!
            buttonArray.append(button)
            labelArray.append(label)
        }
        
        
    }
    @objc private func infoButtonAction() {
        
        infoVC.modalPresentationStyle = .overCurrentContext
        present(infoVC, animated: true)
        
    }
    
    // 눌렀을때 맞는지 틀린지 구별해주는 함수 두개
    func success() {
        
        printResult = 10 - saveSingleton.subtractPoint
        
        
        let alertController = UIAlertController(
            title: "성공입니다!!!", message: "점수 : \(printResult) 점" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "다음게임", style: .default) {
            // FIXME: - 랭킹뷰 넘기기
            _ in
            self.appendData()

            self.kingButton.isHidden = true
            self.startButton.isHidden = true
            self.infoButton.isHidden = true
            self.wolfImageView.isHidden = true
            self.personButton.isHidden = true
            self.balloonLabel.isHidden = true
            self.balloonImageView.isHidden = true
            for x in 0...6 {
                self.buttonArray[x].isHidden = true

            }
            let rankVC = RankingViewController()
            
            rankVC.modalPresentationStyle = .overCurrentContext
            self.present(rankVC, animated: true)
            
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
    
    
    //양 이동 코드
    func sheepShift() {
        
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
    }
    
    @objc func startInfo() {
        startButton.isEnabled = false
        // 도우미 대사 함수
        helperInforText()
        for x in 0...6 {
        buttonArray[x].isEnabled = true
        }
        firstPerform()
        
        
        createAlert(title: "난이도 조절", message: "선택해주세요.")

    }
    // 늑대 이동하는 애니매이션

    func startAnimate() {
        UIView.animate(withDuration: 35) {
            self.wolfImageView.trailingAnchor.constraint(equalTo: self.personButton.leadingAnchor,constant: 15).isActive = true
            self.wolfImageView.centerYAnchor.constraint(equalTo: self.personButton.centerYAnchor).isActive = true
            self.wolfImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            self.wolfImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            
            self.backgroundImageView.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+35, execute: {
            self.startButton.setImage(UIImage(named: "sun2"), for: .normal)
            ///////////////////
            //////////////////////////
            ////////////////////////////
            
            self.kingButton.isHidden = true
            self.startButton.isHidden = true
            self.infoButton.isHidden = true
            self.wolfImageView.isHidden = true
            self.personButton.isHidden = true
            self.balloonLabel.isHidden = true
            self.balloonImageView.isHidden = true
            for x in 0...6 {
                self.buttonArray[x].isHidden = true
                
            }
            let rankVC = RankingViewController()
            
            rankVC.modalPresentationStyle = .overCurrentContext
            self.present(rankVC, animated: true)
            
        })
        
        //일단 말풍선 숨기고.
        balloonLabel.isHidden = true
        balloonImageView.isHidden = true
    }
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let normalLevel = UIAlertAction(title: "NORMARL", style: .default) { _ in
            self.startAnimate()
        }
        
        let hardLevel = UIAlertAction(title: "HARD", style: .default) { _ in
            self.startAnimate()

            
            var pointers :[CGPoint] = [
                CGPoint(x: self.view.frame.minX + 15,y: self.view.frame.maxY - 450),
                CGPoint(x: self.view.frame.maxX - 95, y: self.view.frame.maxY - 450),
                CGPoint(x: self.view.center.x - 120, y: self.view.frame.maxY - 390),
                CGPoint(x: self.view.center.x + 40, y: self.view.frame.maxY - 390),
                CGPoint(x: self.view.center.x - 40 , y: self.view.frame.maxY - 320),
                CGPoint(x: self.view.center.x - 120, y: self.view.frame.maxY - 260),
                CGPoint(x: self.view.center.x + 40, y: self.view.frame.maxY - 260)]
            
            
            UIView.animateKeyframes(
                withDuration: 30, delay: 0, options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0, relativeDuration: 0.3,
                        animations: {
                            pointers.shuffle()
                            for x in 0...6 {
                                self.buttonArray[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
                            }
                    })
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.3, relativeDuration: 0.3,
                        animations: {
                            pointers.shuffle()
                            for x in 0...6 {
                                self.buttonArray[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
                            }
                    })
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.6, relativeDuration: 0.3,
                        animations: {
                            pointers.shuffle()
                            for x in 0...6 {
                                self.buttonArray[x].frame = CGRect(origin: pointers[x], size: CGSize(width: 80, height: 80))
                            }
                    })
                    self.backgroundImageView.layoutIfNeeded()
                    
            })
        }
        
        alert.addAction(normalLevel)
        alert.addAction(hardLevel)
        present(alert, animated: true, completion: nil)
    }
    
    // 안내원 처음 시작 대사
    func helperInforText() {
        balloonLabel.isHidden = false
        balloonImageView.isHidden = false
        let str = "HINT"
        balloonLabel.text = str
    
    }
    
    //안내원 눌렀을 때 나오는 어럿
    @objc func helperSelectButton(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: "무엇을 도와 드릴까요?", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "힌트(점수 -1 감점)", style: .default) {
            _ in
            
            self.saveSingleton.subtractPoint += 1
            self.randomNum()
        }
        let cancelAction = UIAlertAction(title: "스스로 하기", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
//고난도 양 이동
    
    
    
    
    
    
    
    
    
    // 힌트 함수 ( 랜덤 번호 생성하는데, 이미 생성한 번호 있으면 다시 불러와서 겹치지 않게 함)
    func randomNum() {

        guard self.saveNum.count != 7 else { return self.fail() }
        
        let random = Int.random(in: 0...6)
        
        if !saveNum.contains(random) {
            saveNum.append(random)
            labelArray[random].isHidden = false

        } else {
            randomNum()
        }
    }
    
    
}



extension ViewController: InforViewControllerDelegate {
    func changeImage(_ count: Int) {
        self.count = count
        personButton.setImage(UIImage(named:personImage[count]), for: .normal)
        wolfImageView.image = UIImage(named: loseImage[count])
        kingButton.setImage(UIImage(named: winImage[count]), for: .normal)
        
    }
}
