//
//  LaunchViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit
import Network
import Foundation
import CFNetwork
import SystemConfiguration.CaptiveNetwork
import AppTrackingTransparency
import FBSDKCoreKit
import IQKeyboardManagerSwift

let CHANGE_ROOT_VC = NSNotification.Name("CHANGE_ROOT_VC")

class LaunchViewController: BaseViewController {
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle("ENTER", for: .normal)
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        sureBtn.layer.cornerRadius = 20
        sureBtn.clipsToBounds = true
        sureBtn.isHidden = true
        return sureBtn
    }()
    
    let viewModel = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.size.equalTo(CGSize(width: 295, height: 44))
            make.centerX.equalToSuperview()
        }
        
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        
        clickInfo()
        
        getIDFAInfo()
    }
    
    @MainActor
    deinit {
        print("🔹 LaunchViewController deinit!")
    }
    
}

extension LaunchViewController {
    
    @objc func sureBtnClick() {
        clickInfo()
        sureBtn.isEnabled = false
    }
    
    private func clickInfo() {
        let json = LaunchInitInfo.getJsonInfo()
        launchInfo(with: json)
    }
    
    private func launchInfo(with json: [String: Any]) {
        Task {
            do {
                let model = try await viewModel.initLaunchInfo(with: json)
                if model.phacotherapy == "0" {
                    sureBtn.isHidden = true
                    sureBtn.isEnabled = true
                    if let oocystModel = model.billionth?.oocyst {
                        marketModel(with: oocystModel)
                    }
                    pushNoti()
                }else {
                    sureBtn.isHidden = false
                    sureBtn.isEnabled = true
                }
            } catch {
                sureBtn.isHidden = false
                sureBtn.isEnabled = true
            }
        }
        
    }
    
    private func pushNoti() {
        NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil)
    }
    
}

extension LaunchViewController {
    
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
        }
    }
    
    private func marketModel(with model: oocystModel) {
        let scheme = model.snookers ?? ""
        let appID = model.inflictable ?? ""
        let name = model.dispender ?? ""
        let token = model.poinder ?? ""
        
        Settings.shared.appURLSchemeSuffix = scheme
        Settings.shared.appID = appID
        Settings.shared.displayName = name
        Settings.shared.clientToken = token
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
}

class LaunchInitInfo {

    static func getJsonInfo() -> [String: Any] {
        var result: [String: Any] = [:]
        
        let language = Locale.preferredLanguages.first ?? "en"
        result["digiangi"] = language
        
        var proxyEnabled = 0
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] {
            if let httpEnable = proxySettings["HTTPEnable"] as? Int, httpEnable == 1 {
                proxyEnabled = 1
            }
        }
        result["phlebotomic"] = proxyEnabled
        
        var vpnEnabled = 0
        if let cfDict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scopes = cfDict["__SCOPED__"] as? [String: Any] {
            for key in scopes.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                    vpnEnabled = 1
                    break
                }
            }
        }
        result["pausingly"] = vpnEnabled
        
        return result
    }
}

class PushManagerModel {
    static let shared = PushManagerModel()
    private init() {}
    var model: oocystModel?
}
