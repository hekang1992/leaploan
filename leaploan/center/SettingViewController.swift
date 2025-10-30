//
//  SettingViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class SettingViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "common_bg_image")
        view.addSubview(bgImageView)
        view.backgroundColor = UIColor.init(hexString: "#C8E8FB")
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        self.view.addSubview(headView)
        headView.nameLabel.text = AppTitleConfig.settting_title
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headView.clickBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        let outImageView = UIImageView()
        outImageView.isUserInteractionEnabled = true
        outImageView.image = UIImage(named: "kfc_mac_image")
        view.addSubview(outImageView)
        outImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(355)
            make.top.equalTo(headView.snp.bottom)
            make.height.equalTo(397)
        }
        
        let oneBtn = UIButton(type: .custom)
        let twoBtn = UIButton(type: .custom)
        
        outImageView.addSubview(twoBtn)
        outImageView.addSubview(oneBtn)
        
        twoBtn.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(76)
        }
        
        oneBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(twoBtn.snp.top)
            make.height.equalTo(76)
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            self?.tcInfo()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            self?.otInfo()
        }).disposed(by: disposeBag)
        
    }
}

extension SettingViewController {
    
    private func tcInfo() {
        let logoutView = AppPopAlertView(frame: self.view.bounds)
        logoutView.bgImageView.image = UIImage(named: "lee_ip_image")
        let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        
        logoutView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        logoutView.sureBlock = { [weak self] in
            self?.dismiss(animated: true) {
                self?.requestApi(with: "1")
            }
        }
    }
    
    private func otInfo() {
        let logoutView = AppPopAlertView(frame: self.view.bounds)
        logoutView.bgImageView.image = UIImage(named: "tx_id_image")
        let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        
        logoutView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        logoutView.sureBlock = { [weak self] in
            self?.dismiss(animated: true) {
                self?.requestApi(with: "2")
            }
        }
    }
    
    private func requestApi(with type: String) {
        Task {
            do {
                let model = try await viewModel.settingRequestApi(with: type)
                if model.phacotherapy == "0" {
                    LoginAuthManager.removeLoginInfo()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: CHANGE_ROOT_LAUNCH_VC, object: nil)
                    }
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
    }
    
}
