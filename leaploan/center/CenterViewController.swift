//
//  CenterViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    let viewModel = CenterPageViewModel()
    
    lazy var centerView: CenterPageView = {
        let centerView = CenterPageView()
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.centerView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.refreshApi()
        })
        
        centerView.block = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.antisubversive ?? ""
            SchemeURLManagerTool.goPageWithPageUrl(pageUrl, from: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.refreshApi()
        }
    }
}

extension CenterViewController {
    
    private func refreshApi() {
        let json = ["phone": LoginAuthManager.phoneNumber]
        Task {
            do {
                let model = try await viewModel.refreshCenterApi(with: json)
                if model.phacotherapy == "0" {
                    self.centerView.phoneLabel.text = model.billionth?.userInfo?.userphone ?? ""
                    self.centerView.modelArray = model.billionth?.mankin ?? []
                }
                await self.centerView.scrollView.mj_header?.endRefreshing()
            } catch  {
                await self.centerView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
}
