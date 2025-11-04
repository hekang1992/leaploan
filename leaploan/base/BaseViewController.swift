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
