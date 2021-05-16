//
//  LeaderboardCard.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 15.05.2021..
//
import SnapKit
import UIKit

class LeaderboardCard: UITableViewCell {
    
    let cellContentView = UIView()
    let order = UILabel()
    let username = UILabel()
    let score = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        order.font = UIFont(name: "SourceSansPro-Black", size: 20)
        order.textColor = .white
        
        username.font = UIFont(name: "SourceSansPro-SemiBold", size: 18)
        username.textColor = .white
        
        score.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        score.textColor = .white
        
        addSubview(cellContentView)
        cellContentView.addSubview(order)
        cellContentView.addSubview(username)
        cellContentView.addSubview(score)
        
        cellContentView.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
        }
        
        order.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        username.snp.makeConstraints { make -> Void in
            make.leading.equalTo(order.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        score.snp.makeConstraints { make -> Void in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
