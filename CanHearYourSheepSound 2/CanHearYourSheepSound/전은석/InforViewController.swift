//
//  InforViewController.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

protocol InforViewControllerDelegate: class {
    func changeImage(_ count: Int)
}

class InforViewController: UIViewController {

    weak var delegate: InforViewControllerDelegate?
    
    let baseView = UIView()
    let titleLabel = UILabel()
    let yellowAlertActionButton = UIButton()
    let whiteAlertActionButton = UIButton()
    let okAlertActionButton = UIButton()
    
//    let yellowAlertActionButton1 = UIButton()
//    let whiteAlertActionButton1 = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        configure()
        autoLayout()
        
    }
    
    private func configure() {
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 10
        view.addSubview(baseView)
        
        titleLabel.text = "버튼 눌러서 이미지, 난이도 변경"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        yellowAlertActionButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        yellowAlertActionButton.layer.cornerRadius = 45
        yellowAlertActionButton.setTitle("1번 이미지", for: .normal)
        yellowAlertActionButton.addTarget(self, action: #selector(alertActionButtonAction), for: .touchUpInside)
        yellowAlertActionButton.tag = 0
        view.addSubview(yellowAlertActionButton)
        
        whiteAlertActionButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        whiteAlertActionButton.layer.cornerRadius = 45
        whiteAlertActionButton.setTitle("2번 이미지", for: .normal)
        whiteAlertActionButton.addTarget(self, action: #selector(alertActionButtonAction), for: .touchUpInside)
        whiteAlertActionButton.tag = 1
        view.addSubview(whiteAlertActionButton)
        
        
//        yellowAlertActionButton1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        yellowAlertActionButton1.layer.cornerRadius = 45
//        yellowAlertActionButton1.setTitle("쉬움", for: .normal)
//        yellowAlertActionButton1.addTarget(self, action: #selector(alertActionButtonAction), for: .touchUpInside)
//        yellowAlertActionButton1.tag = 2
//        view.addSubview(yellowAlertActionButton1)
//        
//        whiteAlertActionButton1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        whiteAlertActionButton1.layer.cornerRadius = 45
//        whiteAlertActionButton1.setTitle("어려움", for: .normal)
//        whiteAlertActionButton1.addTarget(self, action: #selector(alertActionButtonAction), for: .touchUpInside)
//        whiteAlertActionButton1.tag = 3
//        view.addSubview(whiteAlertActionButton1)
        
        
        
        
        
        okAlertActionButton.layer.cornerRadius = 25
        okAlertActionButton.setTitle("확인", for: .normal)
        okAlertActionButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        okAlertActionButton.addTarget(self, action: #selector(alertActionButtonAction), for: .touchUpInside)
        okAlertActionButton.tag = 2
        okAlertActionButton.backgroundColor = .white
        view.addSubview(okAlertActionButton)
        
    }
    
    private struct Standard {
        static let space: CGFloat = 50
    }
    
    private func autoLayout() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        baseView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 460).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: Standard.space).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        
        yellowAlertActionButton.translatesAutoresizingMaskIntoConstraints = false
        yellowAlertActionButton.leadingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.leadingAnchor, constant: Standard.space).isActive = true
        yellowAlertActionButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: -50).isActive = true
        yellowAlertActionButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        yellowAlertActionButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        whiteAlertActionButton.translatesAutoresizingMaskIntoConstraints = false
        whiteAlertActionButton.trailingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.trailingAnchor, constant: -Standard.space).isActive = true
        whiteAlertActionButton.centerYAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.centerYAnchor,constant: -50).isActive = true
        whiteAlertActionButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        whiteAlertActionButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        
//        yellowAlertActionButton1.translatesAutoresizingMaskIntoConstraints = false
//        yellowAlertActionButton1.leadingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.leadingAnchor, constant: Standard.space).isActive = true
//        yellowAlertActionButton1.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: 60).isActive = true
//        yellowAlertActionButton1.widthAnchor.constraint(equalToConstant: 90).isActive = true
//        yellowAlertActionButton1.heightAnchor.constraint(equalToConstant: 90).isActive = true
//
//        whiteAlertActionButton1.translatesAutoresizingMaskIntoConstraints = false
//        whiteAlertActionButton1.trailingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.trailingAnchor, constant: -Standard.space).isActive = true
//        whiteAlertActionButton1.centerYAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.centerYAnchor,constant: 60).isActive = true
//        whiteAlertActionButton1.widthAnchor.constraint(equalToConstant: 90).isActive = true
//        whiteAlertActionButton1.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        
        
        
        okAlertActionButton.translatesAutoresizingMaskIntoConstraints = false
        okAlertActionButton.bottomAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.bottomAnchor, constant: -Standard.space).isActive = true
        okAlertActionButton.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        okAlertActionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        okAlertActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func alertActionButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0,1,3,4:
            delegate?.changeImage(sender.tag)
        case 2:
            dismiss(animated: true)
        default:
            break
        }
        
    }
    
}
