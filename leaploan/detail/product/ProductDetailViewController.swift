//
//  ProductDetailViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import SnapKit
import MJRefresh
import RxSwift
import RxCocoa
import RxGesture

class ProductDetailViewController: BaseViewController {
    
    let productId: String
    
    let disposeBag = DisposeBag()
    
    init(productId: String) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel = ProductViewModel()
    
    var baseModel: BaseModel?
    
    let misassertViewModel = MisassertViewModel()
    
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
        scroImageView.isUserInteractionEnabled = true
        return scroImageView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "qie_icon_image")
        return descImageView
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
        nameLabel.isUserInteractionEnabled = true
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
            self?.navigationController?.popViewController(animated: true)
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
        
        scroImageView.addSubview(descImageView)
        descImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.left.equalToSuperview().offset(3)
            make.size.equalTo(CGSize(width: 168, height: 44))
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
            make.top.equalTo(descImageView.snp.bottom).inset(8)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        listView.returnBlock = { [weak self] model in
            guard let self = self, let baseModel = baseModel else { return }
            /// NEXT_PAGE_MESSAGE
            let wolvishModel = baseModel.billionth?.wolvish
            let wolvishtilewright = wolvishModel?.tilewright ?? ""
            /// LIST_INFO_MESSAGE
            let isAuth = model.hundredfold ?? 0
            let tilewright = model.tilewright ?? ""
            
            var type: String = ""
            
            type = isAuth == 1 ? tilewright : wolvishtilewright
            
            let pageUrl: String = model.antisubversive ?? ""
            
            RouterNextStepConfig.changePushVc(with: type, pageUrl: pageUrl, vc: self)
            
        }
        
        applyBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self, let baseModel = baseModel else { return }
            let wolvishModel = baseModel.billionth?.wolvish
            let tilewright = wolvishModel?.tilewright ?? ""
            let pageUrl: String = wolvishModel?.antisubversive ?? ""
            RouterNextStepConfig.changePushVc(with: tilewright, pageUrl: pageUrl, vc: self)
        }).disposed(by: disposeBag)
        
        nameLabel.rx.tapGesture().when(.recognized).bind(onNext: { [weak self] _ in
            guard let self = self, let baseModel = baseModel else { return }
            let photodrama = baseModel.billionth?.cosmometry?.photodrama ?? ""
            let webVc = H5WebViewController()
            webVc.pageUrl = photodrama
            self.navigationController?.pushViewController(webVc, animated: true)
        }).disposed(by: disposeBag)
        
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
                self.baseModel = model
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

class RouterNextStepConfig {
    
    static func changePushVc(with type: String,
                             pageUrl: String,
                             vc: ProductDetailViewController,) {
        let json = ["snowier": vc.productId, "hundredfold": type]
        switch type {
        case RouterConfig.ONE_AUTH_STEP:
            Task {
                do {
                    let model = try await vc.viewModel.findFacelInfo(with: json)
                    if model.phacotherapy == "0" {
                        let imageModel = model.billionth?.distinctionless
                        if imageModel?.hundredfold == 0 {
                            let selectVc = SelectAuthViewController()
                            selectVc.productID = vc.productId
                            selectVc.model = model
                            selectVc.baseModel = vc.baseModel
                            vc.navigationController?.pushViewController(selectVc, animated: true)
                        }else {
                            let faceVc = FaceViewController()
                            faceVc.productID = vc.productId
                            faceVc.model = model
                            faceVc.baseModel = vc.baseModel
                            vc.navigationController?.pushViewController(faceVc, animated: true)
                        }
                    }
                } catch  {
                    
                }
            }
            break
        case RouterConfig.TWO_AUTH_STEP:
            let personalVc = PersonalViewController()
            personalVc.productID = vc.productId
            personalVc.baseModel = vc.baseModel
            vc.navigationController?.pushViewController(personalVc, animated: true)
            break
        case RouterConfig.THREE_AUTH_STEP:
            let personalVc = WorkViewController()
            personalVc.productID = vc.productId
            personalVc.baseModel = vc.baseModel
            vc.navigationController?.pushViewController(personalVc, animated: true)
            break
        case RouterConfig.FOUR_AUTH_STEP:
            let personalVc = ConactCheckViewController()
            personalVc.productID = vc.productId
            personalVc.baseModel = vc.baseModel
            vc.navigationController?.pushViewController(personalVc, animated: true)
            break
        case RouterConfig.FIVE_AUTH_STEP:
            let personalVc = H5WebViewController()
            personalVc.productID = vc.productId
            personalVc.pageUrl = pageUrl
            personalVc.type = "1"
            vc.navigationController?.pushViewController(personalVc, animated: true)
            break
        case RouterConfig.SIX_AUTH_STEP:
            let one = String(Int(Date().timeIntervalSince1970))
            let orderID = vc.baseModel?.billionth?.sesti?.caranday ?? ""
            let nasology = vc.baseModel?.billionth?.sesti?.nasology ?? 0
            let expansible = vc.baseModel?.billionth?.sesti?.expansible ?? ""
            let octagonally = vc.baseModel?.billionth?.sesti?.octagonally ?? 0
            let json = ["cognominal": orderID, "nasology": String(nasology), "expansible": expansible, "octagonally": String(octagonally)]
            Task {
                do {
                    let model = try await vc.viewModel.dueOrderInfo(with: json)
                    if model.phacotherapy == "0" {
                        let antisubversive = model.billionth?.antisubversive ?? ""
                        let webVc = H5WebViewController()
                        webVc.productID = vc.productId
                        webVc.pageUrl = antisubversive
                        webVc.orderID = orderID
                        vc.navigationController?.pushViewController(webVc, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            let two = String(Int(Date().timeIntervalSince1970))
                            vc.insertMessageInfo(with: "9",
                                                 onepera: one,
                                                 twopera: two,
                                                 threepera: orderID,
                                                 viewModel: vc.misassertViewModel)
                        }
                    }else {
                        HudToastView.showMessage(with: model.marsi ?? "")
                    }
                } catch  {
                    
                }
            }
            break
        default:
            break
        }
    }
    
}
