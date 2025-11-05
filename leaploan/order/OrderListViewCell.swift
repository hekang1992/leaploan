//
//  OrderListViewCell.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit

class OrderListViewCell: UITableViewCell {
    
    var model: mankinModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.mesopectus ?? ""
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(whiteView)
        bgView.addSubview(oneLabel)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

