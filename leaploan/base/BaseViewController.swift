//
//  BaseViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()
    
    lazy var stepHeadView: StepHeadView = {
        let stepHeadView = StepHeadView()
        return stepHeadView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    
}

extension BaseViewController {
    
    func popAuthListVC() {
        guard let navigationController = self.navigationController else { return }
        if let targetVC = navigationController.viewControllers.first(where: { $0 is ProductDetailViewController }) {
            navigationController.popToViewController(targetVC, animated: true)
        } else {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func insertMessageInfo(with type: String,
                           onepera: String,
                           twopera: String,
                           threepera: String,
                           viewModel: MisassertViewModel) {
        let model = LocationManagerModel.shared.model
        let json = ["cranemen": type,
                    "biogeographically": model?.latitude ?? "",
                    "unlustily": model?.longitude ?? "",
                    "baseheartedness": onepera,
                    "dermis": twopera,
                    "proevolutionist": threepera]
        Task {
            do {
                let _ = try await viewModel.insertMessageInfo(with: json)
            } catch {
                
            }
        }
    }
    
}
