//
//  LoginView.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit

class LoginView: BaseView {

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
        loginImageView.image = UIImage(named: "login_image")
        return loginImageView
    }()
    
    lazy var robetImageView: UIImageView = {
        let robetImageView = UIImageView()
        robetImageView.image = UIImage(named: "login_robet_image")
        return robetImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
