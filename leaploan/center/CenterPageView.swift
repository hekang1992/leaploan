//
//  CenterPageView.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import ActiveLabel
import RxCocoa
import RxSwift
import RxGesture

class CenterPageView: UIView {
    
    var block: ((mankinModel) -> Void)?
    
    var orderBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    var modelArray: [mankinModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            setupGridViews(items: modelArray)
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
    
    lazy var odImageView: UIImageView = {
        let odImageView = UIImageView()
        odImageView.image = UIImage(named: "mc_icon_image")
        return odImageView
    }()
    
    lazy var containerStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 0
        containerStackView.distribution = .fillEqually
        containerStackView.alignment = .fill
        return containerStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bgView.bounds
    }
    
    private func setupUI() {
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
        scrollView.addSubview(odImageView)
        scrollView.addSubview(containerStackView)
    }
    
    private func setupConstraints() {
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
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
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
        odImageView.snp.makeConstraints { make in
            make.top.equalTo(orderImageView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(6)
            make.size.equalTo(CGSize(width: 163, height: 29))
        }
        containerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(odImageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        orderImageView.rx.tapGesture().when(.recognized).bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.orderBlock?()
        }).disposed(by: disposeBag)
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
    
    private func setupGridViews(items: [mankinModel]) {
        containerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in stride(from: 0, to: items.count, by: 2) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.distribution = .fillEqually
            rowStackView.alignment = .fill
            
            let firstItemView = createItemView(with: items[i])
            rowStackView.addArrangedSubview(firstItemView)
            
            if i + 1 < items.count {
                let secondItemView = createItemView(with: items[i + 1])
                rowStackView.addArrangedSubview(secondItemView)
            } else {
                let emptyView = UIView()
                emptyView.backgroundColor = .clear
                rowStackView.addArrangedSubview(emptyView)
            }
            
            containerStackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func createItemView(with model: mankinModel) -> UIView {
        let itemView = CenterListView()
        itemView.model = model
        itemView.rx.tapGesture().when(.recognized).bind(onNext: { [weak self] _ in
            self?.block?(model)
        }).disposed(by: disposeBag)
        return itemView
    }
    
}
