//
//  AppDelegate.swift
//  leaploan
//
//  Created by hekang on 2025/10/27.
//

import UIKit
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        noti()
        rootvc()
        return true
    }
    
}

extension AppDelegate {
    
    private func rootvc() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
    }
    
    private func noti() {
        NotificationCenter.default
            .rx
            .notification(CHANGE_ROOT_VC)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] notification in
                self?.switchChangeRootVc(notification)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func switchChangeRootVc(_ noti: Notification) {
        if LoginAuthManager.isLoggedIn {
            window?.rootViewController = BaseTabBarController()
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
