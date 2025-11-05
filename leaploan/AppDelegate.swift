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
        rootVc()
        return true
    }
    
}

extension AppDelegate {
    
    private func rootVc() {
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
        
        NotificationCenter.default
            .rx
            .notification(CHANGE_ROOT_LAUNCH_VC)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] notification in
                guard let self = self else { return }
                window?.rootViewController = LaunchViewController()
            })
            .disposed(by: disposeBag)
    }
    
    @objc func switchChangeRootVc(_ noti: Notification) {
        if LoginAuthManager.isLoggedIn {
            let tabbar = BaseTabBarController()
            let json = noti.userInfo as? [String: String]
            let index = json?["tabBar"] as? String ?? "0"
            tabbar.selectedIndex = Int(index) ?? 0
            window?.rootViewController = tabbar
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
