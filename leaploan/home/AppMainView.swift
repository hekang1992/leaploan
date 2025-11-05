//
//  AppMainView.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit

class AppMainView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var descModel: cosmometryModel?

    var oneModel: majeureModel?
    
    var twoModelArray: [majeureModel]?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        return collectionView
    }()

    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(bgView)
        addSubview(collectionView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bgView.bounds
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(hexString: "#0156EF").cgColor,
            UIColor(hexString: "#4CB8F5").cgColor,
            UIColor(hexString: "#B7E5FC").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return twoModelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel()
        label.text = twoModelArray?[indexPath.item].sonnetized ?? ""
        label.textAlignment = .center
        label.textColor = .white
        cell.contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderView
            header.model = oneModel
            header.descModel = descModel
            return header
        }
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding * 3
        let width = availableWidth / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 275)
    }
}

// MARK: Header View
class HeaderView: UICollectionReusableView {
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        mainImageView.addSubview(oneLabel)
        mainImageView.addSubview(twoLabel)
        mainImageView.addSubview(threeLabel)
        mainImageView.addSubview(fourLabel)
        mainImageView.addSubview(fiveLabel)
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 248))
        }
        
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
