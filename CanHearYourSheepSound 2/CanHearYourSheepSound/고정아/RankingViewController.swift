//
//  RankingViewController.swift
//  CanHearYourSheepSound
//
//  Created by brian은석 on 24/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    var rankData: [Player] = []
    var tempArray : [Int] = []
    var reversedArray: [Int] = []
    var userInfo: [String:Int] = [:]
    var recordArr: [Int] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        return tableView
    }()
    
    let goToFirstPageButton: UIButton = {
        let button = UIButton(type: .custom)
        let goToFirstPageButton = UIImage(named: "처음으로")!
        button.setImage(goToFirstPageButton, for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchingRankingNum()
        addsubView()
        autoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func addsubView() {
        view.addSubview(tableView)
        view.addSubview(goToFirstPageButton)
    }
    
    //버튼 액션
    
    @objc func didTapCloseButton(_ sender: UIButton){
        
        let view = UIStoryboard.init(name: "Main", bundle: nil)
        let LoginVC = view.instantiateViewController(withIdentifier: "LoginViewController")

        show(LoginVC, sender: nil)
    }
    
    
    func matchingRankingNum() {
        SingleSigle.shared.players.append(Player(name: "앵그리은석", point: 10))
        print(SingleSigle.shared.players)
        let temp = SingleSigle.shared.players
        
        
        print("temp:",temp)
        var result = [Int]()
        tempArray = SingleSigle.shared.players.map { $0.point }
        reversedArray = tempArray.sorted().reversed()
        for str in tempArray {
            if !result.contains(str) && !recordArr.contains(str) {
                result.append(str)
                //                print("result: \(result)")
            } else if let index = result.firstIndex(of: str) {
                result.remove(at: index)
                result.append(str)
            }
            
            reversedArray = result.sorted().reversed()
        }
        
        print("recordArr:", reversedArray)
        print("reversedArr:", reversedArray)
        var users = [Player]()
        SingleSigle.shared.players.forEach { (player) in
            for (i, v) in reversedArray.enumerated(){
                //                print(i,v)
                if player.point == v {
                    users.append(Player(name: player.name, point: player.point, rank: i + 1))
                }
            }
        }
        rankData = users
        
        print("done: ",users)
    }
    func autoLayout() {
        
        let guide = view.safeAreaLayoutGuide
        let margin: CGFloat = 30
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: margin).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -margin).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    
        goToFirstPageButton.translatesAutoresizingMaskIntoConstraints = false
        goToFirstPageButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        goToFirstPageButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: margin * 3).isActive = true
    }
}


extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell

        cell.rankingNum.text = String(rankData[indexPath.row].rank)
        cell.userName.text = rankData[indexPath.row].name
        cell.grade.text = String("점수: \(rankData[indexPath.row].point)")

        return cell
    }
}

