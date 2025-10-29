//
//  LoginView.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit
import ActiveLabel

class LoginView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "tongyongbeijing")
        return bgImageView
    }()
    
    lazy var loginImageView: UIImageView = {
        let loginImageView = UIImageView()
        loginImageView.isUserInteractionEnabled = true
        loginImageView.image = UIImage(named: "login_image")
        return loginImageView
    }()
    
    lazy var robetImageView: UIImageView = {
        let robetImageView = UIImageView()
        robetImageView.image = UIImage(named: "login_robet_image")
        return robetImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Hello!"
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Welcome to Leap Loan"
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return descLabel
    }()
    
    lazy var smsLabel: UILabel = {
        let smsLabel = UILabel()
        smsLabel.text = "SMS login"
        smsLabel.textAlignment = .left
        smsLabel.textColor = UIColor.init(hexString: "#333333")
        smsLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(700))
        return smsLabel
    }()
    
    lazy var mobileLabel: UILabel = {
        let mobileLabel = UILabel()
        mobileLabel.text = "Mobile"
        mobileLabel.textAlignment = .left
        mobileLabel.textColor = UIColor.init(hexString: "#333333")
        mobileLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return mobileLabel
    }()
    
    lazy var mobileView: UIView = {
        let mobileView = UIView()
        mobileView.backgroundColor = UIColor.init(hexString: "#F6F6F6")
        mobileView.layer.cornerRadius = 20
        mobileView.clipsToBounds = true
        return mobileView
    }()
    
    lazy var phoneTextFiled: UITextField = {
        let phoneTextFiled = UITextField()
        phoneTextFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter phone number", attributes: [
            .foregroundColor: UIColor.init(hexString: "#C7C7C7") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        ])
        phoneTextFiled.attributedPlaceholder = attrString
        phoneTextFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        phoneTextFiled.textColor = UIColor.init(hexString: "#333333")
        phoneTextFiled.layer.cornerRadius = 14
        phoneTextFiled.clipsToBounds = true
        phoneTextFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        phoneTextFiled.leftViewMode = .always
        return phoneTextFiled
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.text = "+63"
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.init(hexString: "#333333")
        numLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return numLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hexString: "#979797")
        lineView.layer.cornerRadius = 5
        lineView.clipsToBounds = true
        return lineView
    }()
    
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.text = "Mobile"
        codeLabel.textAlignment = .left
        codeLabel.textColor = UIColor.init(hexString: "#333333")
        codeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return codeLabel
    }()
    
    lazy var codeView: UIView = {
        let codeView = UIView()
        codeView.backgroundColor = UIColor.init(hexString: "#F6F6F6")
        codeView.layer.cornerRadius = 20
        codeView.clipsToBounds = true
        return codeView
    }()
    
    lazy var codeTextFiled: UITextField = {
        let codeTextFiled = UITextField()
        codeTextFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter your secure code", attributes: [
            .foregroundColor: UIColor.init(hexString: "#C7C7C7") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        ])
        codeTextFiled.attributedPlaceholder = attrString
        codeTextFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        codeTextFiled.textColor = UIColor.init(hexString: "#333333")
        codeTextFiled.layer.cornerRadius = 14
        codeTextFiled.clipsToBounds = true
        codeTextFiled.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        codeTextFiled.leftViewMode = .always
        return codeTextFiled
    }()
    
    lazy var lineqView: UIView = {
        let lineqView = UIView()
        lineqView.backgroundColor = UIColor.init(hexString: "#979797")
        lineqView.layer.cornerRadius = 5
        lineqView.clipsToBounds = true
        return lineqView
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Get code", for: .normal)
        codeBtn.setTitleColor(UIColor.init(hexString: "#FF29D5"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("LON IN", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        loginBtn.layer.cornerRadius = 20
        loginBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        return loginBtn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var checkBtn: UIButton = {
        let checkBtn = UIButton(type: .custom)
        checkBtn.setImage(UIImage(named: "check_nor_image"), for: .normal)
        checkBtn.setImage(UIImage(named: "check_sel_image"), for: .selected)
        checkBtn.isSelected = true
        return checkBtn
    }()
    
    lazy var mentLabel: ActiveLabel = {
        let mentLabel = ActiveLabel()
        mentLabel.numberOfLines = 0
        mentLabel.textAlignment = .left
        
        mentLabel.enabledTypes = [.custom(pattern: "Privacy Policy"), .custom(pattern: "Loan Terms")]
        
        mentLabel.text = "Creating An Account Indicates That You Consent To Our Privacy Policy And Loan Terms."
        mentLabel.customColor[.custom(pattern: "Privacy Policy")] = UIColor(hexString: "#FF29D5")
        mentLabel.customColor[.custom(pattern: "Loan Terms")] = UIColor(hexString: "#FF29D5")
        mentLabel.font = .systemFont(ofSize: 12, weight: UIFont.Weight(400))
        mentLabel.textColor = UIColor(hexString: "#979797")
        
        mentLabel.handleCustomTap(for: .custom(pattern: "Privacy Policy")) { _ in
            print("🟢 Privacy Policy tapped")
        }
        
        mentLabel.handleCustomTap(for: .custom(pattern: "Loan Terms")) { _ in
            print("🟢 Loan Terms tapped")
        }
        
        return mentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        
        addSubview(bgView)
        
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(42)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(16)
        }
        
        scrollView.addSubview(loginImageView)
        scrollView.addSubview(robetImageView)
        
        loginImageView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 349, height: 255))
        }
        
        robetImageView.snp.makeConstraints { make in
            make.bottom.equalTo(loginImageView.snp.top).offset(40)
            make.right.equalTo(loginImageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 145, height: 185))
        }
        
        loginImageView.addSubview(smsLabel)
        smsLabel.snp.makeConstraints { make in
            make.height.equalTo(21)
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(44)
        }
        
        loginImageView.addSubview(mobileLabel)
        loginImageView.addSubview(mobileView)
        
        mobileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(69)
            make.height.equalTo(16)
            make.left.equalToSuperview().offset(27)
        }
        
        mobileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 294, height: 40))
            make.top.equalTo(mobileLabel.snp.bottom).offset(12)
        }
        
        mobileView.addSubview(phoneTextFiled)
        phoneTextFiled.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
        
        mobileView.addSubview(numLabel)
        mobileView.addSubview(lineView)
        numLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(phoneTextFiled.snp.left)
            make.top.bottom.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.right.equalTo(phoneTextFiled.snp.left)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(2)
        }
        
        loginImageView.addSubview(codeLabel)
        loginImageView.addSubview(codeView)
        codeView.addSubview(codeTextFiled)
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(mobileView.snp.bottom).offset(29)
            make.height.equalTo(16)
            make.left.equalToSuperview().offset(27)
        }
        codeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 294, height: 40))
            make.top.equalTo(codeLabel.snp.bottom).offset(12)
        }
        codeTextFiled.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(190)
            make.top.bottom.equalToSuperview()
        }
        codeView.addSubview(lineqView)
        lineqView.snp.makeConstraints { make in
            make.left.equalTo(codeTextFiled.snp.right).offset(5)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(2)
        }
        
        codeView.addSubview(codeBtn)
        codeBtn.snp.makeConstraints { make in
            make.left.equalTo(lineqView.snp.right)
            make.right.equalToSuperview()
            make.bottom.top.equalToSuperview()
        }
        
        scrollView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginImageView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 295, height: 44))
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(38)
            make.width.equalTo(300)
            make.bottom.equalToSuperview().offset(-20)
        }
        stackView.addArrangedSubview(checkBtn)
        stackView.addArrangedSubview(mentLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    
    
}
