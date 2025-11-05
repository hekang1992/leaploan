//
//  SelectNameView.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import BRPickerView

class SelectNameView: UIView {
    
    var modelArray: [floroscopeModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    var clickBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "name_icon_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setTitle("OK", for: .normal)
        clickBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        clickBtn.layer.cornerRadius = 22
        clickBtn.setTitleColor(.white, for: .normal)
        return clickBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.register(SelectViewCell.self, forCellReuseIdentifier: "SelectViewCell")
        tableView.register(CommonViewCell.self, forCellReuseIdentifier: "CommonViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(clickBtn)
        bgImageView.addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 499))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        clickBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(CGSize(width: 315, height: 44))
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(146)
            make.bottom.equalTo(clickBtn.snp.top).offset(-20)
        }
        
        cancelBtn.rx.tap.bind(onNext: { [weak self] in
            self?.cancelBlock?()
        }).disposed(by: disposeBag)
        
        clickBtn.rx.tap.bind(onNext: { [weak self] in
            self?.clickBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectNameView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = modelArray?[indexPath.row] else { return UITableViewCell() }
        let cellIdentifier = model.phacotherapy == "dreadlessly" ? "SelectViewCell" : "CommonViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        CellConfigurator.configure(cell, with: model)
        return cell
    }

}


struct CellConfigurator {
   static let disposeBag = DisposeBag()
    static func configure(_ cell: UITableViewCell, with model: floroscopeModel) {
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if let selectCell = cell as? SelectViewCell {
            selectCell.model = model
            selectCell.bgView.backgroundColor = UIColor.init(hexString: "#F1F8FF")
            
            selectCell.codeBtn.rx.tap.bind(onNext: {
                CellConfigurator.selectCellNormalTime(with: selectCell, model: model)
            }).disposed(by: disposeBag)
            
        } else if let commonCell = cell as? CommonViewCell {
            commonCell.model = model
            commonCell.bgView.backgroundColor = UIColor.init(hexString: "#F1F8FF")
        }
    }
    
    static func selectCellNormalTime(with cell: SelectViewCell, model: floroscopeModel) {
       let timeStr = cell.phoneTextFiled.text ?? "1990-11-11"
        let timeArray = timeStr.components(separatedBy: "-")
        let one = timeArray[0]
        let two = timeArray[1]
        let three = timeArray[2]
        
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date of birth"
        datePickerView.minDate = NSDate.br_setYear(1920, month: 11, day: 11)
        datePickerView.selectDate = NSDate.br_setYear(Int(one)!, month: Int(two)!, day: Int(three)!)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { selectDate, selectValue in
            let timeArray = selectValue!.components(separatedBy: "-")
            let year = timeArray[2]
            let mon = timeArray[1]
            let day = timeArray[0]
            cell.phoneTextFiled.text = "\(day)-\(mon)-\(year)"
            model.operculiferous = "\(day)-\(mon)-\(year)"
        }
       let customStyle = BRPickerStyle()
       customStyle.pickerColor = .white
       customStyle.pickerTextFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
       customStyle.selectRowTextColor = UIColor.init(hexString: "#333333")
       datePickerView.pickerStyle = customStyle
       datePickerView.show()
    }
}
