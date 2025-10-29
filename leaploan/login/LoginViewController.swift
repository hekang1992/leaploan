//
//  LoginViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private var timer: Timer?
    private var count = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.codeBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            let phoneStr = self.loginView.phoneTextFiled.text ?? ""
            if phoneStr.isEmpty {
                HudToastView.showMessage(with: "Please enter phone number")
                return
            }
            self.resignResponse()
            self.codeInfo()
        }).disposed(by: disposeBag)
     
        loginView.loginBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.loginInfo()
        }).disposed(by: disposeBag)
        
    }
    
    deinit {
        timer?.invalidate()
    }
    
}

extension LoginViewController {
    
    private func codeInfo() {
        let phone = self.loginView.phoneTextFiled.text ?? ""
        let json = ["disensure": phone,
                    "disponse": "1",
                    "codetime": String(Int(Date().timeIntervalSince1970))]
        Task {
            do {
                let model = try await viewModel.findCodeInfo(with: json)
                if model.phacotherapy == "0"  {
                    startCountdown()
                }
                HudToastView.showMessage(with: model.marsi ?? "")
            } catch  {
                
            }
        }
    }
    
    private func loginInfo() {
        let phone = self.loginView.phoneTextFiled.text ?? ""
        let code = self.loginView.codeTextFiled.text ?? ""
        if phone.isEmpty {
            HudToastView.showMessage(with: "Please enter phone number")
            return
        }
        if code.isEmpty {
            HudToastView.showMessage(with: "Please enter your secure code")
            return
        }
        self.resignResponse()
        let json = ["morts": phone,
                    "harkening": code,
                    "logintime": String(Int(Date().timeIntervalSince1970))]
        Task {
            do {
                let model = try await viewModel.pushLoginInfo(with: json)
                if model.phacotherapy == "0" {
                    let phone = model.billionth?.morts ?? ""
                    let token = model.billionth?.shavery ?? ""
                    LoginAuthManager.saveLoginInfo(with: phone, token: token)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil)
                    }
                }
                HudToastView.showMessage(with: model.marsi ?? "")
            } catch  {
                
            }
        }
    }
    
    private func resignResponse() {
        self.loginView.phoneTextFiled.resignFirstResponder()
        self.loginView.codeTextFiled.resignFirstResponder()
    }
}

extension LoginViewController {
    
    private func startCountdown() {
        loginView.codeBtn.isEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.count -= 1
            if self.count > 0 {
                self.loginView.codeBtn.setTitle("\(self.count)s", for: .normal)
                self.loginView.codeBtn.setTitleColor(UIColor(hexString: "#C7C7C7"), for: .normal)
            } else {
                self.stopCountdown()
            }
        }
    }
    
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        count = 60
        
        loginView.codeBtn.isEnabled = true
        loginView.codeBtn.setTitleColor(UIColor(hexString: "#FF29D5"), for: .normal)
        loginView.codeBtn.setTitle("Get code", for: .normal)
    }
    
    
    
}
