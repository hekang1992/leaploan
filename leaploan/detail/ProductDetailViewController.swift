//
//  ProductDetailViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import MJRefresh

class ProductDetailViewController: BaseViewController {
    
    let productId: String
    
    init(productId: String) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel = ProductViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pd_icon_image")
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var scroImageView: UIImageView = {
        let scroImageView = UIImageView()
        scroImageView.image = UIImage(named: "audio_icon_image")
        return scroImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.isHidden = true
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(200))
        let fullText = "We strictly follow standard procedures and specifications, and specific privacy measures are detailed in the Privacy Policy."
        
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#333333"), range: NSRange(location: 0, length: fullText.count))
        
        if let nightedRange = fullText.range(of: "Privacy Policy") {
            let nsRange = NSRange(nightedRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.init(hexString: "#FF29D5"), range: nsRange)
        }
        
        nameLabel.attributedText = attributedString
        return nameLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setImage(UIImage(named: "apply_ic_image"), for: .normal)
        applyBtn.adjustsImageWhenHighlighted = false
        return applyBtn
    }()
    
    lazy var listView: ProductDetailListView = {
        let listView = ProductDetailListView()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(335)
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headView.clickBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(scroImageView)
        scroImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(219)
            make.size.equalTo(CGSize(width: 355, height: 468))
            make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(scroImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.findProductDetailInfo(with: productId)
        })
        
        view.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-48)
            make.size.equalTo(CGSize(width: 150, height: 68))
        }
        
        scroImageView.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(103)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findProductDetailInfo(with: productId)
    }
    
}

extension ProductDetailViewController {
    
    private func findProductDetailInfo(with productID: String) {
        let json = ["snowier": productID, "approve": LoginAuthManager.phoneNumber]
        Task {
            do {
                let model = try await viewModel.findProductDetailInfo(with: json)
                if model.phacotherapy == "0" {
                    if let cosmometryModel = model.billionth?.cosmometry, let photodrama = cosmometryModel.photodrama, !photodrama.isEmpty {
                        nameLabel.isHidden = false
                    }else {
                        nameLabel.isHidden = true
                    }
                    self.headView.nameLabel.text = model.billionth?.sesti?.sonnetized ?? ""
                    self.listView.modelArray = model.billionth?.gadgeteer ?? []
                }
                await self.scrollView.mj_header?.endRefreshing()
            } catch {
                await self.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
}
