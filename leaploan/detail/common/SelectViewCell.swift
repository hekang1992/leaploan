//
//  SelectViewCell.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SelectViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var clickBlock: ((satanizeModel) -> Void)?
    
    /// LIST_AUTH_INFO
    var listModel: satanizeModel? {
        didSet {
            guard let listModel = listModel else { return }
            nameLabel.text = listModel.nighted ?? ""
            phoneTextFiled.placeholder = listModel.huggermugger ?? ""
            
            let knitwork = listModel.knitwork ?? ""
            phoneTextFiled.text = knitwork
        }
    }
    
    /// SELECT_NAME_ID_DATE_MESSAGE_INFO
    var model: floroscopeModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.responsive ?? ""
            phoneTextFiled.placeholder = model.responsive ?? ""
            phoneTextFiled.text = model.operculiferous ?? ""
        }
    }

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Hello!"
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return nameLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
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
        phoneTextFiled.isEnabled = false
        return phoneTextFiled
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_icon_image")
        return rightImageView
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        return codeBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(rightImageView)
        bgView.addSubview(phoneTextFiled)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 300, height: 16))
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
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
        
        contentView.addSubview(codeBtn)
        codeBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        codeBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self, let listModel = listModel else { return }
            self.clickBlock?(listModel)
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
