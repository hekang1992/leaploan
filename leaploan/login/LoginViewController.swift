//
//  LoginViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit
import FBSDKCoreKit
import AppTrackingTransparency

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getIDFAInfo()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension LoginViewController {
    
    private func getIDFAInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        self.toMarket()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func toMarket() {
        let undersheriffwick = GetDoubleIDManager.shared.getIDFV()
        let soilier = GetDoubleIDManager.shared.getIDFA()
        let json = ["undersheriffwick": undersheriffwick, "soilier": soilier]
        Task {
            let _ = try await viewModel.toAppleMarket(with: json)
            marketModel()
        }
    }
    
    private func marketModel() {
        let model = PushManagerModel.shared.model
        let scheme = model?.snookers ?? ""
        let appID = model?.inflictable ?? ""
        let name = model?.dispender ?? ""
        let token = model?.poinder ?? ""
        
        Settings.shared.appURLSchemeSuffix = scheme
        Settings.shared.appID = appID
        Settings.shared.displayName = name
        Settings.shared.clientToken = token
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
}
