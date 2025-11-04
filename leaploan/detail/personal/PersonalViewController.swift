//
//  PersonalViewController.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    var baseModel: BaseModel?
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "common_bg_image")
        return bgImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setTitle("Next Step", for: .normal)
        clickBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        clickBtn.layer.cornerRadius = 22
        clickBtn.setTitleColor(.white, for: .normal)
        return clickBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        view.addSubview(headView)
        headView.nameLabel.text = "Personal Information"
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headView.clickBlock = { [weak self] in
            guard let self = self else { return }
            let downView = AppPopAlertView(frame: self.view.bounds)
            downView.bgImageView.image = UIImage(named: "lee_ip_image")
            let alertVc = TYAlertController(alert: downView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            
            downView.cancelBlock = {
                self.dismiss(animated: true)
            }
            
            downView.sureBlock = {
                self.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        view.addSubview(stepHeadView)
        stepHeadView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(87)
        }
        
        stepHeadView.configWithModelArray(with: baseModel?.billionth?.gadgeteer ?? [], selectIndex: 1)
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(stepHeadView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(70)
        }
        
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pep_auth_image")
        bgView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 329, height: 105))
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 321, height: 44))
        }
        
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
