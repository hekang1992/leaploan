//
//  StepHeadView.swift
//  leaploan
//
//  Created by hekang on 2025/11/1.
//

import UIKit
import SnapKit

class StepHeadView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configWithModelArray(with modelArray: [gadgeteerModel], selectIndex: Int) {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        // 创建内容视图
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        var previousButton: UIButton?
        
        for (index, model) in modelArray.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            let title = model.tilewright ?? ""
            if index == selectIndex {
                button.isEnabled = false
            }else {
                button.isEnabled = true
            }
            button.setImage(UIImage(named: "\(title)_image"), for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            contentView.addSubview(button)
            buttons.append(button)
            
            let numLabel = UILabel()
            numLabel.text = "\(index + 1)"
            numLabel.textAlignment = .center
            numLabel.textColor = UIColor.init(hexString: "#FFFFFF")
            numLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
            
            button.addSubview(numLabel)
            numLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.left.equalToSuperview().offset(4)
                make.height.equalTo(14)
            }
            
            button.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(84)
                
                if let previous = previousButton {
                    make.leading.equalTo(previous.snp.trailing).offset(5)
                } else {
                    make.leading.equalToSuperview().offset(5)
                }
                
                if index == modelArray.count - 1 {
                    make.trailing.equalToSuperview().offset(-5)
                }
            }
            
            previousButton = button
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
    }
}
