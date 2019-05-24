//
//  LoginViewController.swift
//  doremi
//
//  Created by Daisy on 20/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoView: UIImageView = {
        let image = UIImage(named: "big")
        let logoView = UIImageView(image: image)
        logoView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        logoView.layer.cornerRadius = logoView.frame.width / 2
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    let idLogo: UIImageView = {
        let image = UIImage(named: "id")
        let idLogo = UIImageView(image: image)
        idLogo.translatesAutoresizingMaskIntoConstraints = false
        return idLogo
    }()
    
    let passwdLogo: UIImageView = {
        let image = UIImage(named: "pw")
        let passwdLogo = UIImageView(image: image)
        passwdLogo.translatesAutoresizingMaskIntoConstraints = false
        return passwdLogo
    }()
    
    let idTextField: UITextField = {
        let idTextField = UITextField()
        let attrString = NSAttributedString(
            string: "ID",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)]
        )
        idTextField.attributedPlaceholder = attrString
        idTextField.font = UIFont.systemFont(ofSize: 22, weight: .light)
//        idTextField.enablesReturnKeyAutomatically = true
        idTextField.borderStyle = .none
//        idTextField.returnKeyType = .go
        idTextField.autocorrectionType = .no //자동완성 지우기
        idTextField.autocapitalizationType = .none //첫문자 대문자 안되게 막기
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        return idTextField
    }()
    
    let passwdTextField: UITextField = {
        let passwdTextField = UITextField()
        let nameTextField = UITextField()
        let attrString = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)]
        )
        passwdTextField.attributedPlaceholder = attrString
        passwdTextField.font = UIFont.systemFont(ofSize: 22, weight: .light)
//        passwdTextField.enablesReturnKeyAutomatically = true
        passwdTextField.borderStyle = .none
//        passwdTextField.returnKeyType = .go
        passwdTextField.autocorrectionType = .no //자동완성 지우기
        passwdTextField.autocapitalizationType = .none //첫문자 대문자 안되게 막기
        passwdTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwdTextField
    }()
    
    let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GO", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        passwdTextField.delegate = self
        view.backgroundColor = .white
        addsubView()
        autoLayout()

    }
    
    func addsubView() {
        view.addSubview(logoView)
        view.addSubview(idLogo)
        view.addSubview(passwdLogo)
        view.addSubview(idTextField)
        view.addSubview(passwdTextField)
        view.addSubview(enterButton)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        
    }
    
    //로그인시 ID 또는 PW 누락시 alert창 띄우기
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func autoLayout(){
        let guaid = view.safeAreaLayoutGuide
        let margin: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            logoView.topAnchor.constraint(equalTo: guaid.topAnchor, constant: margin),
            logoView.leadingAnchor.constraint(equalTo: guaid.leadingAnchor, constant: margin),
            logoView.trailingAnchor.constraint(equalTo: guaid.trailingAnchor, constant: -margin),
            
            idLogo.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: margin),
            idLogo.leadingAnchor.constraint(equalTo: guaid.leadingAnchor, constant: margin),
            idLogo.trailingAnchor.constraint(equalTo: idTextField.leadingAnchor, constant: -margin),
            
            idTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: margin),
            idTextField.centerYAnchor.constraint(equalTo: idLogo.centerYAnchor),
            idTextField.trailingAnchor.constraint(equalTo: guaid.trailingAnchor),
            
            passwdLogo.topAnchor.constraint(equalTo: idLogo.bottomAnchor, constant: margin),
            passwdLogo.leadingAnchor.constraint(equalTo: guaid.leadingAnchor, constant: margin),
            passwdLogo.trailingAnchor.constraint(equalTo: passwdTextField.leadingAnchor, constant: -margin),
            
            passwdTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: margin),
            passwdTextField.centerYAnchor.constraint(equalTo: passwdLogo.centerYAnchor),
            passwdTextField.trailingAnchor.constraint(equalTo: guaid.trailingAnchor),
            
//            enterButton.topAnchor.constraint(equalTo: passwdTextField.bottomAnchor, constant: margin),
//            enterButton.centerXAnchor.constraint(equalTo: passwdTextField.centerXAnchor),
//            enterButton.leadingAnchor.constraint(equalTo: guaid.leadingAnchor, constant: margin),
//            enterButton.trailingAnchor.constraint(equalTo: guaid.trailingAnchor, constant: -margin),
//            enterButton.bottomAnchor.constraint(equalTo: guaid.bottomAnchor, constant: margin),
            
            
            ])
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if idTextField.text!.isEmpty {
         createAlert(title: "사용자 이름이 누락되었습니다", message: "")
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let rankVC = storyBoard.instantiateViewController(withIdentifier: "RankingViewController")
        

//        let thirdVC = ThirdViewController()
        let rankingVC = RankingViewController()

        self.show(rankingVC, sender: nil)

  
//        thirdVC.userNameLabel.text = idTextField.text
        
        
        return true
    }
}
