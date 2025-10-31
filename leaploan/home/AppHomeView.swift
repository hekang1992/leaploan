//
//  AppHomeView.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class AppHomeView: UIView {
    
    var isClick: String = "0"
    
    let disposeBag = DisposeBag()
    
    var applyBlock: ((String) -> Void)?
    
    var model: majeureModel? {
        didSet {
            guard let model = model else { return }
            let desc = model.kenai ?? ""
            oneLabel.text = "\(desc)(₱) "
            twoLabel.text = model.cabaho ?? ""
            let petaliform = model.petaliform ?? ""
            threeLabel.text = "Daily interest rate(\(petaliform))"
            fourLabel.text = model.mesopectus ?? ""
        }
    }
    
    var descModel: cosmometryModel? {
        didSet {
            guard let descModel = descModel else {
                fiveLabel.isHidden = true
                return
            }
            fiveLabel.isHidden = false
            
            let nighted = descModel.nighted ?? ""
            let fullText = "Review the \"\(nighted)\""
            
            let attributedString = NSMutableAttributedString(string: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#333333"), range: NSRange(location: 0, length: fullText.count))
            
            if !nighted.isEmpty, let nightedRange = fullText.range(of: nighted) {
                let nsRange = NSRange(nightedRange, in: fullText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#FF29D5"), range: nsRange)
            }
            
            fiveLabel.attributedText = attributedString
            
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "home_bg_image")
        return bgImageView
    }()
    
    lazy var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.image = UIImage(named: "home_ban_image")
        return bannerImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Loan with Ease, Repay at Your Pace"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(400))
        return nameLabel
    }()
    
    lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.image = UIImage(named: "home_apple_image")
        mainImageView.isUserInteractionEnabled = true
        return mainImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(900))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .center
        twoLabel.textColor = UIColor.init(hexString: "#303030")
        twoLabel.font = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight(700))
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .center
        threeLabel.textColor = UIColor.init(hexString: "#303030")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return threeLabel
    }()
    
    lazy var fourLabel: UILabel = {
        let fourLabel = UILabel()
        fourLabel.textAlignment = .center
        fourLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        fourLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(500))
        fourLabel.backgroundColor = UIColor.init(hexString: "#FE63D3")
        fourLabel.layer.cornerRadius = 20
        fourLabel.clipsToBounds = true
        return fourLabel
    }()
    
    lazy var fiveLabel: UILabel = {
        let fiveLabel = UILabel()
        fiveLabel.textAlignment = .center
        fiveLabel.textColor = UIColor.init(hexString: "#333333")
        fiveLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return fiveLabel
    }()
    
    lazy var footView: UIView = {
        let footView = UIView()
        footView.backgroundColor = .white
        footView.layer.cornerRadius = 10
        footView.layer.masksToBounds = true
        return footView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton()
        oneBtn.setTitle("Application\nProcedure", for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        oneBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        oneBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        oneBtn.titleLabel?.numberOfLines = 0
        oneBtn.titleLabel?.textAlignment = .center
        oneBtn.layer.cornerRadius = 10
        oneBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton()
        twoBtn.setTitle("Advantages of\nBorrowing", for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        twoBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        twoBtn.backgroundColor = UIColor.init(hexString: "#75D9FF")
        twoBtn.titleLabel?.numberOfLines = 0
        twoBtn.titleLabel?.textAlignment = .center
        twoBtn.layer.cornerRadius = 10
        twoBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return twoBtn
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "desc_one_image")
        footImageView.isUserInteractionEnabled = true
        return footImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(452)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
        
        scrollView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 331, height: 62))
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        scrollView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(272)
            make.size.equalTo(CGSize(width: 355, height: 248))
        }
        
        mainImageView.addSubview(oneLabel)
        mainImageView.addSubview(twoLabel)
        mainImageView.addSubview(threeLabel)
        mainImageView.addSubview(fourLabel)
        mainImageView.addSubview(fiveLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(21)
        }
        twoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(66)
            make.height.equalTo(48)
        }
        threeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoLabel.snp.bottom).offset(10)
            make.height.equalTo(12)
        }
        fourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 255, height: 40))
        }
        fiveLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fourLabel.snp.bottom).offset(10)
            make.height.equalTo(12)
        }
        
        scrollView.addSubview(footView)
        footView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 394))
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        
        footView.addSubview(oneBtn)
        footView.addSubview(twoBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 178, height: 66))
        }
        twoBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 178, height: 66))
        }
        
        scrollView.addSubview(footImageView)
        footImageView.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 328))
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
            self?.oneBtn.backgroundColor = .white
            self?.twoBtn.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
            self?.twoBtn.backgroundColor = UIColor.init(hexString: "#75D9FF")
            self?.footImageView.image = UIImage(named: "desc_one_image")
            self?.isClick = "0"
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            self?.twoBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
            self?.twoBtn.backgroundColor = .white
            self?.oneBtn.setTitleColor(UIColor.init(hexString: "#FFFFFF"), for: .normal)
            self?.oneBtn.backgroundColor = UIColor.init(hexString: "#75D9FF")
            self?.footImageView.image = UIImage(named: "desc_two_image")
            self?.isClick = "1"
        }).disposed(by: disposeBag)
        
        self.footImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self, let model = model else { return }
                if self.isClick == "1" {
                    self.applyBlock?(String(model.negrita ?? 0))
                }
            }).disposed(by: disposeBag)
        
        self.mainImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self, let model = model else { return }
                self.applyBlock?(String(model.negrita ?? 0))
            }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
