//
//  other.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import Toast_Swift

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&hexValue)
        
        self.init(hex: UInt32(hexValue), alpha: alpha)
    }
}

class HudToastView {
    static func showMessage(with message: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        window.makeToast(message, duration: 3.0, position: .center)
    }
}

class SchemeURLManagerTool {
    
    enum SchemePath: String {
        case setting = "Acontias"
        case home = "unfleshed"
        case login = "trigly"
        case order = "likelihoods"
        case productDetail = "mediastinum"
        
        var path: String {
            return "/\(rawValue)"
        }
    }
    
    static func goPageWithPageUrl(_ pageUrl: String, from viewController: BaseViewController) {
        guard let url = URL(string: pageUrl), pageUrl.hasPrefix(API.schemeURL) else {
            openWebPage(with: pageUrl, from: viewController)
            return
        }
        routeToPage(with: url, from: viewController)
    }
    
    private static func routeToPage(with url: URL, from viewController: BaseViewController) {
        let path = url.path
        switch path {
        case SchemePath.setting.path:
            navigateToSettingPage(from: viewController)
        case SchemePath.home.path:
            navigateToHomePage(from: viewController)
        case SchemePath.login.path:
            navigateToLoginPage(from: viewController)
        case SchemePath.order.path:
            navigateToOrderPage(from: viewController)
        case SchemePath.productDetail.path:
            navigateToProductDetailPage(with: url, from: viewController)
        default:
            handleUnknownScheme(from: viewController)
        }
    }
    
    private static func navigateToSettingPage(from viewController: BaseViewController) {
         let settingVC = SettingViewController()
         viewController.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    private static func navigateToHomePage(from viewController: BaseViewController) {
        let json = ["tabBar": "0"]
        NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil, userInfo: json)
    }
    
    private static func navigateToLoginPage(from viewController: BaseViewController) {
        LoginAuthManager.removeLoginInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            let json = ["tabBar": "0"]
            NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil, userInfo: json)
        }
    }
    
    private static func navigateToOrderPage(from viewController: BaseViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            let json = ["tabBar": "1"]
            NotificationCenter.default.post(name: CHANGE_ROOT_VC, object: nil, userInfo: json)
        }
    }
    
    private static func navigateToProductDetailPage(with url: URL, from viewController: BaseViewController) {
         if let productId = extractProductId(from: url) {
             let detailVC = ProductDetailViewController(productId: productId)
             viewController.navigationController?.pushViewController(detailVC, animated: true)
         }
    }
    
    private static func handleUnknownScheme(from viewController: BaseViewController) {
        print("Unknown scheme path")
    }
    
    private static func openWebPage(with urlString: String, from viewController: BaseViewController) {
        let webVC = H5WebViewController()
        webVC.pageUrl = urlString
        viewController.navigationController?.pushViewController(webVC, animated: true)
    }
    
    private static func extractProductId(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        return queryItems.first(where: { $0.name == "snowier" })?.value
    }
}
