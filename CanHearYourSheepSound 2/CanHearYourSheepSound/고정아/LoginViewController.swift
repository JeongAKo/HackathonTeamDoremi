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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addsubView()
        autoLayout()
    }
    
    @objc func didTapButton(_ sender: UIButton){
        
    }
    
    func addsubView(){
        view.addSubview(idTextField)
        view.addSubview(loginButton)
    }
    
    func autoLayout(){
        
    }

}
