//
//  LoginViewController.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var abata: UIImageView!
    
    @IBOutlet weak var gameStartButton: UIButton!
    
    
    //유저 이미지 아이콘들.
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100 , height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageView.isUserInteractionEnabled = true

//전은석 추가--------------------
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "check")
        collectionView.isScrollEnabled = false
        firstmake()
        makeView()
        collectionView.backgroundColor = .white
//여기까지---------------------
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.isHidden = true
        abata.isHidden = true
        gameStartButton.isHidden = true
        imageView.isUserInteractionEnabled = true

    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
   
    
    
    //로그인 버튼
    @IBAction func checkButton(_ sender: Any) {
        
        idTextField.resignFirstResponder()
        
        
        if idTextField.text!.isEmpty {
            createAlert(title: "사용자 이름이 누락되었습니다", message: "")
        } else {
            imageView.isHidden = false
            abata.isHidden = false
            gameStartButton.isHidden = false
        }
    }
    
    @IBAction func chachaButton(_ sender: UIButton) {
        infoLabel.text! = "아야!"
        infoButton.isEnabled = true
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        sender.isEnabled = false
        let str = "게임을 시작하시면 양들이 순서대로 튀어오릅니다. 순서대로 클릭하시면 완료되는 게임입니다. 노래는 '무엇이 무엇이 똑같을까' 입니다."
        for x in str {
            infoLabel.text! += "\(x)"
            RunLoop.current.run(until: Date()+0.05)
        }
        
    }
    
    
    @IBAction func gameStartAction(_ sender: Any) {
        
        let mainVC = ViewController()
        self.show(mainVC, sender: nil)
        mainVC.userNameLabel.text = idTextField.text
        
    }
    
    
    
    
    
//전은석 추가--------------------
    let leftButton = UIButton()
    let rightButton = UIButton()
    let gif = ["cat","bird","dog"]
    
    func firstmake() {
        let arr = [collectionView,leftButton,rightButton]
        for x in arr {
            imageView.addSubview(x)
            x.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func makeView() {
        collectionView.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 190).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        leftButton.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 210).isActive = true
        leftButton.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor,constant: -20).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        leftButton.addTarget(self, action: #selector(actButton(_:)), for: .touchUpInside)
        leftButton.setImage(UIImage(named: "Left"), for: .normal)
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.tag = 0
        
        rightButton.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 210).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: collectionView.trailingAnchor,constant: 20).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        rightButton.addTarget(self, action: #selector(actButton(_:)), for: .touchUpInside)
        rightButton.setImage(UIImage(named: "Right"), for: .normal)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.tag = 1
        
    }
    @objc func actButton(_ sender: UIButton) {
        if sender.tag == 0 {
            let move = CGPoint(x: collectionView
                .contentOffset.x - collectionView.frame.width - 10, y: 0)
            if collectionView.contentOffset.x == 0 {
                collectionView.contentOffset.x = 220
            } else {
                collectionView.contentOffset = move
            }
            print(collectionView.contentOffset)
        } else if sender.tag == 1 {
            let move = CGPoint(x: collectionView
                .contentOffset.x + collectionView.frame.width + 10, y: 0)
            if collectionView.contentOffset.x == 220 {
                collectionView.contentOffset.x = 0
            } else {
                collectionView.contentOffset = move
            }
            print(collectionView.contentOffset)
            
            
        }
    }
//여기까지---------------------

}

//전은석 추가 -----------------------
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gif.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as! CustomCollectionViewCell
        cell.imageView.loadGif(name: gif[indexPath.row])
        return cell
    }
    
    
}
//여기까지---------------------


