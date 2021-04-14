//
//  QuizCard.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.04.2021..
//

import Foundation
import SnapKit
import UIKit

class QuizCard: UITableViewCell {
    
    let icon = UIImageView(image: UIImage(named: "football-strategy.jpeg"))
    let title = UILabel()
    let desc = UILabel()
    let difficulty = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont(name: "ArialMT", size: 12)
        desc.font = UIFont(name: "ArialMT", size: 10)
        difficulty.font = UIFont(name: "ArialMT", size: 12)
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(desc)
        contentView.addSubview(difficulty)
        
        contentView.snp.makeConstraints { make -> Void in
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        icon.snp.makeConstraints { make -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 80, height: 70))
        }
        
        title.snp.makeConstraints { make -> Void in
            make.top.equalTo(icon.snp.top).offset(10)
            make.left.equalTo(icon.snp.right).offset(5)
        }
        
        desc.snp.makeConstraints { make -> Void in
            make.left.equalTo(title.snp.left)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        
        difficulty.snp.makeConstraints { make -> Void in
            make.top.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
}
