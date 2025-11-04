//
//  ChoosePhotoView.swift
//  leaploan
//
//  Created by hekang on 2025/11/2.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ChoosePhotoView: UIView {
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    var photoBlock: (() -> Void)?
    var cameraBlock: (() -> Void)?

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "phot_pop_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 649))
            make.centerX.equalToSuperview()
        }
        
        oneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        threeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-36)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 44))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalTo(threeBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 44))
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cancelBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cameraBlock?()
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.photoBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ChooseFaceView: UIView {
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    var cameraBlock: (() -> Void)?

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "face_pop_auth_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 649))
            make.centerX.equalToSuperview()
        }
        
        oneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-36)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 50))
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cancelBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cameraBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
