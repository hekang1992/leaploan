//
//  BaseTabBarController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = BaseNavigationController(rootViewController: HomeViewController())
        let ordersVC = BaseNavigationController(rootViewController: OrderViewController())
        let profileVC = BaseNavigationController(rootViewController: CenterViewController())
        
        homeVC.tabBarItem = createTabBarItem(
            imageName: "home_nor_image",
            selectedImageName: "home_sel_image"
        )
        
        ordersVC.tabBarItem = createTabBarItem(
            imageName: "order_nor_image",
            selectedImageName: "order_sel_image"
        )
        
        profileVC.tabBarItem = createTabBarItem(
            imageName: "center_nor_image",
            selectedImageName: "center_sel_image"
        )
        
        profileVC.tabBarItem = createTabBarItem(
            imageName: "center_nor_image",
            selectedImageName: "center_sel_image"
        )
        
        self.viewControllers = [homeVC, ordersVC, profileVC]
        
        hideTabBarTitles()
    }
    
    private func createTabBarItem(imageName: String, selectedImageName: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        )
        
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return tabBarItem
    }
    
    private func hideTabBarTitles() {
        if let items = tabBar.items {
            for item in items {
                item.title = nil
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
    }
}
