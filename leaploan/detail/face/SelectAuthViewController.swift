//
//  SelectAuthViewController.swift
//  leaploan
//
//  Created by hekang on 2025/11/1.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SelectAuthViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    var model: BaseModel?
    
    var baseModel: BaseModel?
    
    var modelArray: [String]?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "common_bg_image")
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle("Recommanded", for: .normal)
        oneBtn.setTitleColor(.white, for: .selected)
        oneBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        oneBtn.isSelected = true
        oneBtn.layer.cornerRadius = 17
        oneBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle("Other", for: .normal)
        twoBtn.setTitleColor(.white, for: .selected)
        twoBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        twoBtn.layer.cornerRadius = 17
        twoBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return twoBtn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(FaceTableViewCell.self, forCellReuseIdentifier: "FaceTableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        headView.nameLabel.text = "Proof Of Identity"
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        headView.clickBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        whiteView.layer.masksToBounds = true
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 50))
        }
        
        whiteView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stackView.addArrangedSubview(oneBtn)
        stackView.addArrangedSubview(twoBtn)
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.isSelected = true
            self?.twoBtn.isSelected = false
            self?.oneBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
            self?.twoBtn.backgroundColor = UIColor.white
            self?.modelArray = self?.model?.billionth?.somebodies ?? []
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            self?.oneBtn.isSelected = false
            self?.twoBtn.isSelected = true
            self?.oneBtn.backgroundColor = UIColor.white
            self?.twoBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
            self?.modelArray = self?.model?.billionth?.myectopy ?? []
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom).offset(15)
            make.left.right.bottom.equalToSuperview()
        }
        
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "da_icon_adc_image")
        scrollView.addSubview(descImageView)
        descImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 44))
        }
        
        let fottView = UIView()
        fottView.layer.cornerRadius = 12
        fottView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        fottView.layer.masksToBounds = true
        fottView.backgroundColor = UIColor.white
        scrollView.addSubview(fottView)
        fottView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom)
            make.size.equalTo(CGSize(width: 355, height: 438))
            make.bottom.equalToSuperview().offset(-20)
        }
        
        fottView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        self.modelArray = self.model?.billionth?.somebodies ?? []
        self.tableView.reloadData()
    }

}

extension SelectAuthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaceTableViewCell", for: indexPath) as! FaceTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.nameLabel.text = modelArray?[indexPath.row] ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let faceVc = FaceViewController()
        faceVc.type = modelArray?[indexPath.row] ?? ""
        faceVc.productID = productID
        faceVc.model = model
        faceVc.baseModel = baseModel
        self.navigationController?.pushViewController(faceVc, animated: true)
    }
    
}
