//
//  LoginViewController.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let idTextField: UITextField = {
        let idTextField = UITextField()
        let attrString = NSAttributedString(
            string: "ID",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)]
        )
        idTextField.attributedPlaceholder = attrString
        idTextField.font = UIFont.systemFont(ofSize: 22, weight: .light)
        idTextField.borderStyle = .none
        idTextField.autocorrectionType = .no //자동완성 지우기
        idTextField.autocapitalizationType = .none //첫문자 대문자 안되게 막기
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        return idTextField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GO", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
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
        addsubView()
        autoLayout()
        
//전은석 추가--------------------
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "check")
        collectionView.isScrollEnabled = false
        firstmake()
        makeView()
//여기까지---------------------
    }
    
    @objc func didTapButton(_ sender: UIButton){
        
    }
    
    func addsubView(){
        view.addSubview(idTextField)
        view.addSubview(loginButton)
    }
    
    func autoLayout(){
        
    }
    
    
//전은석 추가--------------------
    let leftButton = UIButton()
    let rightButton = UIButton()
    let gif = ["cat","bird","dog"]
    
    func firstmake() {
        let arr = [collectionView,leftButton,rightButton]
        for x in arr {
            view.addSubview(x)
            x.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func makeView() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 100).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        leftButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 120).isActive = true
        leftButton.trailingAnchor.constraint(equalTo: collectionView.leadingAnchor,constant: -20).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        leftButton.addTarget(self, action: #selector(actButton(_:)), for: .touchUpInside)
        leftButton.setTitle("왼쪽", for: .normal)
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.tag = 0
        
        rightButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 120).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: collectionView.trailingAnchor,constant: 20).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        rightButton.addTarget(self, action: #selector(actButton(_:)), for: .touchUpInside)
        rightButton.setTitle("오른쪽", for: .normal)
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


