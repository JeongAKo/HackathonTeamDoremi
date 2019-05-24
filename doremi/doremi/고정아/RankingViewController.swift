//
//  RankingViewController.swift
//  doremi
//
//  Created by Daisy on 22/05/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var rankData: [Player] = []
    override func viewDidLoad() {

        super.viewDidLoad()
        
        createData()

        
    }

    func createData() {
        SingleSigle.shared.players.append(Player(name: "헤지", point: 0))
        SingleSigle.shared.players.append(Player(name: "앵그리", point: 10))
        
        let tempArra = SingleSigle.shared.players.map { $0.point }
        let reversedArray = tempArra.sorted().reversed()
        
        reversedArray.forEach { (temp) in
            for player in SingleSigle.shared.players {
                if temp == player.point {
                    rankData.append(player)
                }
            }
        }
        
        print(SingleSigle.shared.players)
        print(rankData)
        
    }
    
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustonCell
        
        cell.rankingNum.text = String(indexPath.row + 1)
        cell.userName.text = rankData[indexPath.row].name
        cell.grade.text = String(rankData[indexPath.row].point)
    
        
        return cell
    }
    
    
    
}
