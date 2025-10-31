//
//  OrderViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrderViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = OrderListViewModel()
    
    var orderType: String = "7"
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle("Repayment", for: .normal)
        oneBtn.setTitleColor(.white, for: .selected)
        oneBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        oneBtn.isSelected = true
        oneBtn.layer.cornerRadius = 17
        oneBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle("Apply", for: .normal)
        twoBtn.setTitleColor(.white, for: .selected)
        twoBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        twoBtn.layer.cornerRadius = 17
        twoBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitle("Finished", for: .normal)
        threeBtn.setTitleColor(.white, for: .selected)
        threeBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        threeBtn.layer.cornerRadius = 17
        threeBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return threeBtn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(OrderListViewCell.self, forCellReuseIdentifier: "OrderListViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#C8E8FB")
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "coc_bg_image")
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(220)
        }
        
        self.view.addSubview(headView)
        headView.backBtn.isHidden = true
        headView.nameLabel.text = AppTitleConfig.order_title
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headView.clickBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        let clickImageView = UIImageView()
        clickImageView.image = UIImage(named: "opc_icon_image")
        view.addSubview(clickImageView)
        clickImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 355, height: 100))
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(10)
        }
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        whiteView.layer.masksToBounds = true
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(clickImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 50))
        }
        
        whiteView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stackView.addArrangedSubview(oneBtn)
        stackView.addArrangedSubview(twoBtn)
        stackView.addArrangedSubview(threeBtn)
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.isSelected = true
            self?.twoBtn.isSelected = false
            self?.threeBtn.isSelected = false
            self?.oneBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
            self?.twoBtn.backgroundColor = UIColor.white
            self?.threeBtn.backgroundColor = UIColor.white
            self?.orderType = "7"
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.isSelected = false
            self?.twoBtn.isSelected = true
            self?.threeBtn.isSelected = false
            self?.oneBtn.backgroundColor = UIColor.white
            self?.twoBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
            self?.threeBtn.backgroundColor = UIColor.white
            self?.orderType = "6"
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.isSelected = false
            self?.twoBtn.isSelected = false
            self?.threeBtn.isSelected = true
            self?.oneBtn.backgroundColor = UIColor.white
            self?.twoBtn.backgroundColor = UIColor.white
            self?.threeBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
            self?.orderType = "5"
        }).disposed(by: disposeBag)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListInfo(with: orderType)
    }
    
}

extension OrderViewController {
    
    private func getListInfo(with orderType: String) {
        let json = ["immoralised": orderType]
        Task {
            do {
                let model = try await viewModel.getOrderListInfo(with: json)
            } catch  {
                
            }
        }
    }
    
}
