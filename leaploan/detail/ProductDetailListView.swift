//
//  ProductDetailListView.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit

class ProductDetailListView: UIView {
    
    let disposeBag = DisposeBag()
    
    lazy var containerStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 0
        containerStackView.distribution = .fillEqually
        containerStackView.alignment = .fill
        return containerStackView
    }()
    
    var modelArray: [gadgeteerModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            setupGridViews(items: modelArray)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductDetailListView {
    
    private func setupGridViews(items: [gadgeteerModel]) {
        containerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in stride(from: 0, to: items.count, by: 2) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.distribution = .fillEqually
            rowStackView.alignment = .fill
            
            let firstItemView = createItemView(with: items[i])
            rowStackView.addArrangedSubview(firstItemView)
            
            if i + 1 < items.count {
                let secondItemView = createItemView(with: items[i + 1])
                rowStackView.addArrangedSubview(secondItemView)
            } else {
                let emptyView = UIView()
                emptyView.backgroundColor = .clear
                rowStackView.addArrangedSubview(emptyView)
            }
            
            containerStackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func createItemView(with model: gadgeteerModel) -> UIView {
        let itemView = ProductListView()
        itemView.model = model
        itemView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                
            })
            .disposed(by: disposeBag)
        return itemView
    }
    
}
