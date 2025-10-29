//
//  LoginViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()

    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
