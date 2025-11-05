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
import BRPickerView

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    var baseModel: BaseModel?
    
    let disposeBag = DisposeBag()
    
    let viewModel = PersonalViewModel()
    
    let dataSource = BehaviorRelay<[satanizeModel]>(value: [])
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(CommonViewCell.self, forCellReuseIdentifier: "CommonViewCell")
        tableView.register(SelectViewCell.self, forCellReuseIdentifier: "SelectViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
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
                    self.popAuthListVC()
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
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 329, height: 105))
        }
        
        let graniImageView = UIImageView()
        graniImageView.isUserInteractionEnabled = true
        graniImageView.image = UIImage(named: "auth_bg_icon_image")
        bgView.addSubview(graniImageView)
        graniImageView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 321, height: 44))
        }
        
        graniImageView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        dataSource
            .bind(to: tableView.rx.items) { [weak self] (tableView, row, element) in
                return self?.configureCell(for: tableView, at: row, with: element) ?? UITableViewCell()
            }
            .disposed(by: disposeBag)
        
        clickBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            var json: [String: String] = ["snowier": productID]
            self.dataSource.value.forEach { model in
                let desulfurization = model.desulfurization ?? ""
                let key = model.phacotherapy ?? ""
                if desulfurization == "topsmelts" {
                    let dictValue = String(model.frypans ?? 0)
                    json[key] = dictValue == "0" ? "" : dictValue
                }else {
                    json[key] = model.knitwork
                }
            }
            self.saveInfo(with: json)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListInfo()
    }
    
    private func saveInfo(with json: [String: String]) {
        Task {
            do {
                let model = try await viewModel.savePersonalInfo(with: json)
                if model.phacotherapy == "0" {
                    self.popAuthListVC()
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
    }
    
}


extension PersonalViewController {
    
    private func configureCell(for tableView: UITableView, at row: Int, with element: satanizeModel) -> UITableViewCell {
        if element.desulfurization == "tweezing" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonViewCell") as! CommonViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.listModel = element
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectViewCell") as! SelectViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.listModel = element
            cell.clickBlock = { [weak self] satanizeModel in
                guard let self = self else { return }
                self.clickCellWithModel(with: cell, model: satanizeModel)
            }
            return cell
        }
    }
    
    private func getListInfo() {
        let json = ["snowier": productID]
        Task {
            do {
                let model = try await viewModel.getPersonalInfo(with: json)
                if model.phacotherapy == "0" {
                    self.dataSource.accept(model.billionth?.satanize ?? [])
                }
            } catch  {
                
            }
        }
    }
    
    private func clickCellWithModel(with cell: SelectViewCell, model: satanizeModel) {
        let desulfurization = model.desulfurization ?? ""
        if desulfurization == "topsmelts" {
            let modelArray = model.veritism ?? []
            setupPickerView(model: model, textField: cell.phoneTextFiled, array: modelArray)
        }else {
            let addressCityModelArray = HomeAddressModel.shared.cityModelArray ?? []
            setupadressPickerView(model: model, textField: cell.phoneTextFiled, array: addressCityModelArray)
        }
    }
    
}

extension PersonalViewController {
    
    func setupPickerView(model: satanizeModel, textField: UITextField, array: [veritismModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        let enumArray = EnumModel.getFirstModelArray(dataSourceArr: array)
        stringPickerView.title = model.nighted ?? ""
        stringPickerView.dataSourceArr = enumArray
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            textField.text = provinceName
            model.knitwork = provinceName
            model.frypans = Int(province?.code ?? "0")
        }
        configurePickerStyle(for: stringPickerView)
    }
    
    func setupadressPickerView(model: satanizeModel, textField: UITextField, array: [BRProvinceModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .area
        stringPickerView.title = model.nighted ?? ""
        stringPickerView.dataSourceArr = array
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let areaName = area?.name ?? ""
            let addressString = provinceName + "|" + cityName + "|" + areaName
            textField.text = addressString
            model.knitwork = addressString
        }
        configurePickerStyle(for: stringPickerView)
        
    }
    
    private func configurePickerStyle(for pickerView: BRAddressPickerView) {
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        customStyle.selectRowTextColor = UIColor.init(hexString: "#333333")
        pickerView.pickerStyle = customStyle
        pickerView.show()
    }
    
}
