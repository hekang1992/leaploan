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
    
    lazy var minView: AppMainView = {
        let minView = AppMainView()
        return minView
    }()
    
    let viewModel = AppHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.isHidden = true
        minView.isHidden = true
        
        view.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(minView)
        minView.snp.makeConstraints { make in
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
        
        self.minView.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeMessageInfo()
        })
        
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
                            self.homeView.isHidden = false
                            self.minView.isHidden = true
                        }else if ["bullethead", "sporocystid"].contains(frypans) {
                            self.homeView.isHidden = true
                            self.minView.isHidden = false
                            if frypans == "bullethead" {
                                self.minView.twoModelArray = model.majeure ?? []
                            } else if frypans == "sporocystid" {
                                self.minView.oneModel = model.majeure?.first
                            }
                            self.minView.descModel = descModel
                            self.minView.collectionView.reloadData()
                        }
                    }
                }
                Task {
                    self.homeView.scrollView.mj_header?.endRefreshing()
                    self.minView.collectionView.mj_header?.endRefreshing()
                }
            } catch  {
                Task {
                    self.homeView.scrollView.mj_header?.endRefreshing()
                    self.minView.collectionView.mj_header?.endRefreshing()
                }
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
        if pageURL.contains(API.schemeURL) {
            SchemeURLManagerTool.goPageWithPageUrl(pageURL, from: self)
        }else {
            let webVc = H5WebViewController()
            webVc.pageUrl = pageURL
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
    }
    
}
