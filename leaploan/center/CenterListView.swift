//
//  CenterListView.swift
//  leaploan
//
//  Created by hekang on 2025/10/30.
//

import UIKit
import SnapKit
import Kingfisher

class CenterListView: UIView {
    
    var model: mankinModel? {
        didSet {
            guard let model = model else { return }
            iconImageView.kf.setImage(with: URL(string: model.unworthily ?? ""))
            nameLabel.text = model.nighted ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bgView.layer.shadowRadius = 4
        bgView.layer.shadowOpacity = 0.1
        return bgView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "lis_cie_image")
        return iconImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.contentMode = .scaleAspectFit
        descImageView.image = UIImage(named: "lis_cie_image")
        return descImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 172, height: 99))
            make.bottom.equalToSuperview().offset(-10)
        }
        
        bgView.addSubview(iconImageView)
        bgView.addSubview(descImageView)
        bgView.addSubview(nameLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 45, height: 12))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(5)
            make.height.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
