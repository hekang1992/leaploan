//
//  OrderListViewCell.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import Kingfisher

class OrderListViewCell: UITableViewCell {
    
    var model: mankinModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.mesopectus ?? ""
            let logoUrl = model.sporogenous ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.sonnetized ?? ""
            moneyLabel.text =  model.hexametrical ?? ""
            typeView.nameLabel.text = "Check"
            
            coverListView(with: model.fixates ?? [])
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 12
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return whiteView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        oneLabel.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        return oneLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#2C78E6")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        lineView.layer.cornerRadius = 5
        lineView.layer.masksToBounds = true
        return lineView
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#000000")
        moneyLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(700))
        return moneyLabel
    }()
    
    lazy var typeView: OrderCheckView = {
        let typeView = OrderCheckView()
        return typeView
    }()
    
    lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.init(hexString: "#EBFAFF")
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        coverView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return coverView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(whiteView)
        bgView.addSubview(oneLabel)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(lineView)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(typeView)
        bgView.addSubview(coverView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 193))
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
        whiteView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.right.equalToSuperview()
        }
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(-50)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(30)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(6)
            make.height.equalTo(18)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(47)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(6)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(22)
        }
        typeView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(28)
        }
        coverView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(lineView.snp.left)
            make.right.equalTo(lineView.snp.right)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension OrderListViewCell {
    
    private func coverListView(with modelArray: [fixatesModel]) {
        coverView.subviews.forEach { $0.removeFromSuperview() }
        
        guard !modelArray.isEmpty else { return }
        
        var previousView: OrderListMinView?
        
        for (index, item) in modelArray.enumerated() {
            let listView = OrderListMinView()
            listView.model = item
            coverView.addSubview(listView)
            
            listView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(14)
                
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom).offset(10)
                } else {
                    make.top.equalToSuperview().offset(10)
                }
                if index == modelArray.count - 1 {
                    make.bottom.lessThanOrEqualToSuperview().offset(-10)
                }
            }
            previousView = listView
        }
    }
    
}
