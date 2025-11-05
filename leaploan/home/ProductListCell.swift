//
//  ProductListCell.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import UIKit
import SnapKit

class ProductListCell: UICollectionViewCell {
    
    var model: majeureModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.sonnetized ?? ""
            oneLabel.text = model.kenai ?? ""
            twpLabel.text = model.cabaho ?? ""
            leftView.nameLabel.text = model.chiefdom ?? ""
            rightView.nameLabel.text = model.squinty ?? ""
            let mesopectus = model.mesopectus ?? ""
            applyLabel.isHidden = mesopectus.isEmpty ? true : false
            applyLabel.text = model.mesopectus ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var layerView: UIView = {
        let layerView = UIView()
        layerView.backgroundColor = UIColor.init(hexString: "#DBF6FF")
        layerView.layer.cornerRadius = 10
        layerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layerView.layer.masksToBounds = true
        return layerView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "center_sel_image")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#2C78E6")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return oneLabel
    }()
    
    lazy var twpLabel: UILabel = {
        let twpLabel = UILabel()
        twpLabel.textAlignment = .center
        twpLabel.textColor = UIColor.init(hexString: "#000000")
        twpLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(700))
        return twpLabel
    }()
    
    lazy var leftView: ProductItemListView = {
        let leftView = ProductItemListView()
        leftView.bgImageView.image = UIImage(named: "itwm_dat_image")
        return leftView
    }()
    
    lazy var rightView: ProductItemListView = {
        let rightView = ProductItemListView()
        rightView.bgImageView.image = UIImage(named: "itwm_live_image")
        return rightView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        applyLabel.layer.cornerRadius = 14
        applyLabel.clipsToBounds = true
        applyLabel.backgroundColor = UIColor.init(hexString: "#FF29D5")
        return applyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgView)
        bgView.addSubview(layerView)
        layerView.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(nameLabel)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twpLabel)
        bgView.addSubview(leftView)
        bgView.addSubview(rightView)
        bgView.addSubview(applyLabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        layerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 148, height: 37))
        }
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
        }
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        oneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(layerView.snp.bottom).offset(5)
            make.height.equalTo(14)
        }
        twpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneLabel.snp.bottom).offset(5)
            make.height.equalTo(22)
        }
        leftView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(twpLabel.snp.bottom).offset(10)
            make.height.equalTo(12)
        }
        rightView.snp.makeConstraints { make in
            make.left.equalTo(leftView.snp.right).offset(10)
            make.centerY.equalTo(leftView.snp.centerY)
            make.height.equalTo(12)
        }
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 80, height: 28))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
