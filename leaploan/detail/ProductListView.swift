//
//  ProductListView.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import Kingfisher

class ProductListView: UIView {
    
    var model: gadgeteerModel? {
        didSet {
            guard let model = model else { return }
            bgImageView.kf.setImage(with: URL(string: model.scrutinizer ?? ""))
            nameLabel.text = model.nighted ?? ""
            descLabel.text = model.huggermugger ?? ""
            let hundredfold = model.hundredfold ?? 0
            completeImageView.isHidden = hundredfold == 1 ? false : true
            rightImageView.isHidden = hundredfold == 1 ? true : false
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.backgroundColor = .systemBlue
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_icon_image")
        return rightImageView
    }()
    
    lazy var completeImageView: UIImageView = {
        let completeImageView = UIImageView()
        completeImageView.image = UIImage(named: "complete_icon_image")
        completeImageView.isHidden = true
        return completeImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#979797")
        descLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(300))
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.addSubview(rightImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(completeImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(120)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(120)
        }
        
        completeImageView.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
