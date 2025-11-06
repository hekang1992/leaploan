//
//  HomeViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import MJRefresh
import CoreLocation

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
    
    let firstViewModel = LaunchViewModel()
    
    let misassertViewModel = MisassertViewModel()
    
    let locationManager = AppLocationManager()
    
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
            homeMessageApiInfo()
        })
        
        homeView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            findLocationStatus(with: productID)
        }
        
        homeView.descBlock = { [weak self] pageUrl in
            let webVc = H5WebViewController()
            webVc.pageUrl = pageUrl
            self?.navigationController?.pushViewController(webVc, animated: true)
        }
        
        /// MINVIEW_PAGE_INFO
        self.minView.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            homeMessageApiInfo()
        })
        
        self.minView.smallBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(model.negrita ?? 0)
            findLocationStatus(with: productID)
        }
        
        self.minView.agreementBlock = { [weak self] model in
            guard let self = self else { return }
            let photodrama = model.photodrama ?? ""
            let webVc = H5WebViewController()
            webVc.pageUrl = photodrama
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        self.minView.productListBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(model.negrita ?? 0)
            findLocationStatus(with: productID)
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
        homeMessageApiInfo()
    }
    
    private func homeMessageApiInfo() {
        findLocationModelInfo()
        getHomeMessageInfo()
        toMarket()
    }
    
}

extension HomeViewController {
    
    /// GET_GOOGLE_MARKET_MESSAGE_INFO
    private func toMarket() {
        let undersheriffwick = GetDoubleIDManager.shared.getIDFV()
        let soilier = GetDoubleIDManager.shared.getIDFA()
        let json = ["undersheriffwick": undersheriffwick, "soilier": soilier]
        Task {
            do {
                let _ = try await firstViewModel.toAppleMarket(with: json)
            } catch  {
                
            }
        }
    }
    
    /// GET_LOCATION_STATUS
    private func findLocationStatus(with productID: String) {
        let model = PushManagerModel.shared.model
        let accidentalness = model?.billionth?.accidentalness ?? 0
        if accidentalness == 1 {
            let status = CLLocationManager().authorizationStatus
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                applyProductInfo(with: productID)
            } else if status == .denied || status == .restricted {
                if shouldShowPermissionAlert() {
                    showPermissionAlert()
                }else {
                    applyProductInfo(with: productID)
                }
            }
        }else {
            applyProductInfo(with: productID)
        }
    }
    
    private func showPermissionAlert() {
        DispatchQueue.main.async {
            guard let vc = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return }
            
            let alert = UIAlertController(
                title: "无法访问定位",
                message: "请前往设置开启定位权限以使用此功能。",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "取消", style: .cancel))
            alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }))
            vc.present(alert, animated: true)
            
            self.recordPermissionAlertShown()
        }
    }
    
    private func shouldShowPermissionAlert() -> Bool {
        let defaults = UserDefaults.standard
        let lastShownDate = defaults.object(forKey: "PermissionAlertLastShown") as? Date
        
        guard let lastDate = lastShownDate else {
            return true
        }
        
        let twentyFourHours: TimeInterval = 24 * 60 * 60
        return Date().timeIntervalSince(lastDate) > twentyFourHours
    }
    
    private func recordPermissionAlertShown() {
        let defaults = UserDefaults.standard
        defaults.set(Date(), forKey: "PermissionAlertLastShown")
    }
    
    private func findLocationModelInfo() {
        locationManager.getCurrentLocation { model in
            LocationManagerModel.shared.model = model
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let model = LocationManagerModel.shared.model
                let thysanurian = model?.country ?? ""
                let biogeographically = model?.latitude ?? ""
                let unlustily = model?.longitude ?? ""
                if !thysanurian.isEmpty && !biogeographically.isEmpty && !unlustily.isEmpty {
                    let json: [String: Any] = [
                        "cuisse": model?.province ?? "",
                        "swooping": model?.countryCode ?? "",
                        "thysanurian": model?.country ?? "",
                        "backboneless": model?.address ?? "",
                        "biogeographically": model?.latitude ?? "",
                        "unlustily": model?.longitude ?? "",
                        "twanging": model?.city ?? "",
                        "rump": model?.subLocality ?? ""
                    ]
                    
                    Task {
                        do {
                            let _ = try await self.viewModel.backLocationendInfo(with: json)
                        } catch {
                            print("error======: \(error)")
                        }
                    }
                }
                
            }
        }
    }
    
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
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
        
        let one = UserDefaults.standard.object(forKey: "one") as? String ?? ""
        let two = UserDefaults.standard.object(forKey: "one") as? String ?? ""
        Task.detached { [weak self] in
            guard let self = self else { return }
            await self.insertMessageInfo(
                with: "1",
                onepera: one,
                twopera: two,
                threepera: "",
                viewModel: misassertViewModel
            )
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
