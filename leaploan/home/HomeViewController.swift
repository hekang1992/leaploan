//
//  HomeViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    lazy var homeView: AppHomeView = {
        let homeView = AppHomeView()
        return homeView
    }()
    
    let viewModel = AppHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeMessageInfo()
        })
        
        homeView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            applyProductInfo(with: productID)
        }
        
        Task {
            do {
              let _ = try await viewModel.getCityAddressInfo(with: ["cleantha": "01"])
            } catch  {
                
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeMessageInfo()
    }
    
}

extension HomeViewController {
    
    private func getHomeMessageInfo() {
        let json = ["louting": "1", "scrutinizer": LoginAuthManager.phoneNumber]
        Task {
            do {
                let model = try await viewModel.findHomeInfo(with: json)
                let modelArray = model.billionth?.mankin ?? []
                let descModel = model.billionth?.cosmometry
                if !modelArray.isEmpty {
                    modelArray.forEach { model in
                        let frypans = model.frypans ?? ""
                        if frypans == "interpret" {
                            self.homeView.model = model.majeure?.first
                            self.homeView.descModel = descModel
                        }
                    }
                }
                await self.homeView.scrollView.mj_header?.endRefreshing()
            } catch  {
                await self.homeView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func applyProductInfo(with productID: String) {
        let json = ["snowier": productID]
        Task {
            do {
                let model = try await viewModel.applyProductInfo(with: json)
                if model.phacotherapy == "0" {
                    if let billionthModel = model.billionth {
                        withModel(with: billionthModel)
                    }
                }
            } catch  {
                
            }
        }
    }
    
    private func withModel(with model: billionthModel) {
        let pageURL = model.antisubversive ?? ""
        SchemeURLManagerTool.goPageWithPageUrl(pageURL, from: self)
    }
    
}
