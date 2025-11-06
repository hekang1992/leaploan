//
//  OrderCenterViewController.swift
//  leaploan
//
//  Created by hekang on 2025/11/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MJRefresh

class OrderCenterViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var modelArray: [mankinModel]?
    
    let viewModel = OrderListViewModel()
    
    lazy var emptyView: AppEmptyView = {
        let emptyView = AppEmptyView(frame: .zero)
        return emptyView
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
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#C8E8FB")
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "coc_bg_image")
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(220)
        }
        
        self.view.addSubview(headView)
        headView.nameLabel.text = "Order List"
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
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.setDataSource(self).disposed(by: disposeBag)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getListInfo(with: "4")
        })
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(2)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        
        emptyView.clickBlock = {
            let json = ["tabBar": "0"]
            NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil, userInfo: json)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListInfo(with: "4")
    }
}

extension OrderCenterViewController {
    
    private func getListInfo(with orderType: String) {
        let json = ["immoralised": orderType]
        Task {
            do {
                let model = try await viewModel.getOrderListInfo(with: json)
                if model.phacotherapy == "0" {
                    let modelArray = model.billionth?.mankin ?? []
                    if modelArray.count > 0 && !modelArray.isEmpty {
                        emptyView.isHidden = true
                    }else {
                        emptyView.isHidden = false
                    }
                    self.modelArray = modelArray
                    self.tableView.reloadData()
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
                await self.tableView.mj_header?.endRefreshing()
            } catch  {
                await self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension OrderCenterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListViewCell", for: indexPath) as! OrderListViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let model = modelArray?[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray?[indexPath.row]
        let wakita = model?.wakita ?? ""
        SchemeURLManagerTool.goPageWithPageUrl(wakita, from: self)
    }
    
}
