//
//  CenterViewController.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    lazy var centerView: CenterPageView = {
        let centerView = CenterPageView()
        return centerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.centerView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.centerView.scrollView.mj_header?.endRefreshing()
            }
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
