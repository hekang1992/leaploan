//
//  FaceTableViewCell.swift
//  leaploan
//
//  Created by hekang on 2025/11/1.
//

import UIKit
import SnapKit

class FaceTableViewCell: UITableViewCell {
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "rangel_image")
        return bgImageView
    }()
    
    lazy var bgImageView2: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "se_id_image")
        return bgImageView
    }()
    
    lazy var bgImageView3: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "sttu_image")
        return bgImageView
    }()
    
    lazy var bgImageView4: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "icon_ric_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Hello!"
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView1)
        bgView.addSubview(bgImageView2)
        bgView.addSubview(bgImageView3)
        bgImageView3.addSubview(bgImageView4)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 335, height: 64))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        bgImageView1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 272, height: 64))
            make.left.equalToSuperview()
        }
        
        bgImageView2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 48, height: 48))
            make.left.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bgImageView2.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        bgImageView3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 74, height: 64))
            make.right.equalToSuperview().offset(-10)
        }
        
        bgImageView4.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
