//
//  AppEmptyView.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture

class AppEmptyView: UIView {
    
    var clickBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_dat_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 201, height: 304))
        }
        
        bgImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.clickBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
