//
//  OrderListMinView.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import UIKit
import SnapKit

class OrderListMinView: UIView {
    
    var model: fixatesModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.nighted ?? ""
            twoLabel.text = model.chondroblast ?? ""
        }
    }
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#979797")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hexString: "#979797")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return twoLabel
    }()
    
    lazy var cycleView: UIView = {
        let cycleView = UIView()
        cycleView.backgroundColor = UIColor.init(hexString: "#FEC808")
        cycleView.layer.cornerRadius = 3
        cycleView.layer.masksToBounds = true
        return cycleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneLabel)
        addSubview(twoLabel)
        addSubview(cycleView)
        
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
            make.left.equalToSuperview().offset(10)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
            make.right.equalToSuperview().offset(-10)
        }
        
        cycleView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 6, height: 6))
            make.centerY.equalToSuperview()
            make.right.equalTo(twoLabel.snp.left).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
