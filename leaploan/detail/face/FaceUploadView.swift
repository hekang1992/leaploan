//
//  FaceUploadView.swift
//  leaploan
//
//  Created by hekang on 2025/11/2.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture

class FaceUploadView: UIView {
    
    let disposeBag = DisposeBag()
    
    var umidClick: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 12
        return bgView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "face_iamge_desc")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "auth_imag_list")
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var photoListView: FaceUploadListView = {
        let photoListView = FaceUploadListView()
        photoListView.nameLabel.text = "Identity Photo"
        photoListView.bgImageView.image = UIImage(named: "photo_lis_image")
        return photoListView
    }()
    
    lazy var faceListView: FaceUploadListView = {
        let faceListView = FaceUploadListView()
        faceListView.nameLabel.text = "Face Identification"
        faceListView.bgImageView.image = UIImage(named: "face_up_image")
        return faceListView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 355, height: 742))
            make.bottom.equalToSuperview().offset(-20)
        }
        
        bgView.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 80))
        }
        
        bgView.addSubview(twoImageView)
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(14)
            make.size.equalTo(CGSize(width: 315, height: 106))
        }
        
        twoImageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(94)
            make.height.equalTo(15)
        }
        
        scrollView.addSubview(photoListView)
        scrollView.addSubview(faceListView)
        
        photoListView.snp.makeConstraints { make in
            make.top.equalTo(twoImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 315, height: 230))
            make.centerX.equalToSuperview()
        }
        
        faceListView.snp.makeConstraints { make in
            make.top.equalTo(photoListView.snp.bottom).offset(25)
            make.size.equalTo(CGSize(width: 315, height: 230))
            make.centerX.equalToSuperview()
        }
        
        twoImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.umidClick?()
            }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
