//
//  AppHeadView.swift
//  leaploan
//
//  Created by hekang on 2025/10/30.
//

import UIKit
import SnapKit
import  RxSwift
import RxCocoa

typealias ClickBlock = () -> Void
class AppHeadView: UIView {
    
    let disposeBag = DisposeBag()
    
    var clickBlock: ClickBlock?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()

    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "back_icon_image"), for: .normal)
        return backBtn
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 280, height: 20))
        }
        
        backBtn.rx.tap.bind(onNext: { [weak self] in
            self?.clickBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
