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
    
    private let CORNER_RADIUS: CGFloat = 10
    
    let cellContentView = UIView()
    let icon = UIImageView(image: UIImage(named: "football"))
    let title = UILabel()
    let desc = UILabel()
    let difficulty = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellContentView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cellContentView.layer.cornerRadius = CORNER_RADIUS
        
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = CORNER_RADIUS
        
        title.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        title.textColor = .white
        title.numberOfLines = 0
        title.preferredMaxLayoutWidth = 200
        
        desc.font = UIFont(name: "SourceSansPro-SemiBold", size: 14)
        desc.textColor = .white
        desc.numberOfLines = 0
        
        difficulty.font = UIFont(name: "SourceSansPro-SemiBold", size: 13)
        difficulty.textColor = .white
        
        addSubview(cellContentView)
        cellContentView.addSubview(icon)
        cellContentView.addSubview(title)
        cellContentView.addSubview(desc)
        cellContentView.addSubview(difficulty)
        
        cellContentView.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        }
        
        icon.snp.makeConstraints { make -> Void in
            make.leading.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(15)
            make.width.lessThanOrEqualTo(100)
        }
        
        title.snp.makeConstraints { make -> Void in
            make.top.equalTo(icon.snp.top).offset(15)
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)        }
        
        desc.snp.makeConstraints { make -> Void in
            make.leading.equalTo(title.snp.leading)
            make.trailing.equalToSuperview().inset(15)
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
    
}
