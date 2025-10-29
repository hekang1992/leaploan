//
//  CenterPageView.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import ActiveLabel

class CenterPageView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "common_bg_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Individual Center"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 50
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "blue_share_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "shing_icon_image")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "gol_icon_image")
        return threeImageView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "head_icon_image")
        return headImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = LoginAuthManager.phoneNumber
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = UIColor.init(hexString: "#1ABFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        return phoneLabel
    }()
    
    lazy var mentLabel: UILabel = {
        let mentLabel = UILabel()
        mentLabel.textAlignment = .center
        let attributedString = NSMutableAttributedString(
            string: "Welcome to Leap Loan",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor(hexString: "#333333")
            ]
        )
        if let range = attributedString.string.range(of: "Leap Loan") {
            let nsRange = NSRange(range, in: attributedString.string)
            attributedString.addAttribute(.font,
                                          value: UIFont.systemFont(ofSize: 12, weight: .bold),
                                        range: nsRange)
        }
        mentLabel.attributedText = attributedString
        
        return mentLabel
    }()
    
    lazy var orderImageView: UIImageView = {
        let orderImageView = UIImageView()
        orderImageView.image = UIImage(named: "opc_icon_image")
        orderImageView.isUserInteractionEnabled = true
        return orderImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(nameLabel)
        addSubview(bgView)
        addSubview(oneImageView)
        addSubview(twoImageView)
        addSubview(threeImageView)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(phoneLabel)
        scrollView.addSubview(mentLabel)
        scrollView.addSubview(orderImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 200, height: 18))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(74)
            make.left.right.bottom.equalToSuperview()
        }
        oneImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.left.equalToSuperview().inset(78)
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.left.equalTo(headImageView.snp.right).inset(-25)
        }
        threeImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(22)
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.right.equalToSuperview().inset(26)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).inset(-10)
            make.height.equalTo(18)
        }
        mentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.height.equalTo(12)
        }
        orderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mentLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 355, height: 114))
        }
        
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bgView.bounds
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(hexString: "#CEE2FD").cgColor,
            UIColor(hexString: "#F5FAFF").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
