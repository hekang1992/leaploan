//
//  PhoneConnectViewCell.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneConnectViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var relationBlock: ((cronieModel) -> Void)?
    var phoneBlock: ((cronieModel) -> Void)?
    
    var model: cronieModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.nighted ?? ""
            oneLabel.text = model.uncontinently ?? ""
            phoneTextFiled.placeholder = model.unmanliest ?? ""
            phoneTextFiled.text = model.knitwork ?? ""
            
            twoLabel.text = model.indexes ?? ""
            nameTextFiled.placeholder = model.odontography ?? ""
            
            let name = model.unmalted ?? ""
            let phone = model.obsequiosity ?? ""
            let laseStr = name + "-" + phone
            nameTextFiled.text = laseStr == "-" ? "" : laseStr
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "php_bg_image")
        return bgImageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stackView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "php_title_image")
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Hello!"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#FF29D5")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return oneLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 22
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var phoneTextFiled: UITextField = {
        let phoneTextFiled = UITextField()
        phoneTextFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        phoneTextFiled.textColor = UIColor.init(hexString: "#FF29D5")
        phoneTextFiled.backgroundColor = .clear
        phoneTextFiled.layer.cornerRadius = 14
        phoneTextFiled.clipsToBounds = true
        phoneTextFiled.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        phoneTextFiled.leftViewMode = .always
        return phoneTextFiled
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_icon_image")
        rightImageView.contentMode = .scaleAspectFit
        return rightImageView
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return twoLabel
    }()
    
    lazy var bgTwoView: UIView = {
        let bgTwoView = UIView()
        bgTwoView.backgroundColor = .white
        bgTwoView.layer.cornerRadius = 22
        bgTwoView.layer.masksToBounds = true
        return bgTwoView
    }()
    
    lazy var nameTextFiled: UITextField = {
        let nameTextFiled = UITextField()
        nameTextFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        nameTextFiled.textColor = UIColor.init(hexString: "#FF29D5")
        nameTextFiled.backgroundColor = .clear
        nameTextFiled.layer.cornerRadius = 14
        nameTextFiled.clipsToBounds = true
        nameTextFiled.leftView = UIView(frame: CGRectMake(0, 0, 10, 10))
        nameTextFiled.leftViewMode = .always
        return nameTextFiled
    }()
    
    lazy var rightIconImageView: UIImageView = {
        let rightIconImageView = UIImageView()
        rightIconImageView.image = UIImage(named: "phone_lis_icon_image")
        rightIconImageView.contentMode = .scaleAspectFit
        return rightIconImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(stackView)
        stackView.addArrangedSubview(descImageView)
        stackView.addArrangedSubview(nameLabel)
        contentView.addSubview(oneLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(phoneTextFiled)
        bgView.addSubview(rightImageView)
        
        contentView.addSubview(twoLabel)
        contentView.addSubview(bgTwoView)
        bgTwoView.addSubview(nameTextFiled)
        bgTwoView.addSubview(rightIconImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(20)
            make.left.equalTo(bgImageView.snp.left)
            make.height.equalTo(16)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        phoneTextFiled.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.right.equalTo(rightImageView.snp.left).offset(-10)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(20)
            make.left.equalTo(bgImageView.snp.left)
            make.height.equalTo(16)
        }
        
        bgTwoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        rightIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        nameTextFiled.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.right.equalTo(rightIconImageView.snp.left).offset(-10)
        }
        
        bgView.addSubview(oneBtn)
        bgTwoView.addSubview(twoBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        twoBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self, let model = model else { return }
            self.relationBlock?(model)
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self, let model = model else { return }
            self.phoneBlock?(model)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
