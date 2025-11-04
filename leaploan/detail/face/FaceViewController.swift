//
//  FaceViewController.swift
//  leaploan
//
//  Created by hekang on 2025/11/1.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController

class FaceViewController: BaseViewController {
    
    var productID: String = ""
    
    var type: String = ""
    
    var model: BaseModel?
    
    var baseModel: BaseModel?
    
    var faceModel: BaseModel?
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "common_bg_image")
        return bgImageView
    }()
    
    lazy var faceUploadView: FaceUploadView = {
        let faceUploadView = FaceUploadView()
        return faceUploadView
    }()
    
    let viewModel = ProductViewModel()
    
    let faceViewModel = FaceViewModel()
    
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
        
        stepHeadView.configWithModelArray(with: baseModel?.billionth?.gadgeteer ?? [])
        
        view.addSubview(faceUploadView)
        faceUploadView.snp.makeConstraints { make in
            make.top.equalTo(stepHeadView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        
        faceUploadView.nameLabel.text = type
        
        faceUploadView.umidClick = { [weak self] in
            let distinctionlessModel = self?.faceModel?.billionth?.distinctionless
            let idstatus = distinctionlessModel?.hundredfold ?? 0
            //            let facestatus = distinctionlessModel?.hundredfold ?? 0
            if idstatus == 0 {
                self?.navigationController?.popViewController(animated: true)
            }else {
                HudToastView.showMessage(with: "Identity verification completed.")
            }
        }
        
        faceUploadView.photoListView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let distinctionlessModel = self?.faceModel?.billionth?.distinctionless
                let idstatus = distinctionlessModel?.hundredfold ?? 0
                //            let facestatus = distinctionlessModel?.hundredfold ?? 0
                if idstatus == 0 {
                    self?.alertPhotoView()
                }else {
                    HudToastView.showMessage(with: "Identity verification completed.")
                }
            }).disposed(by: disposeBag)
        
        faceUploadView.faceListView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let distinctionlessModel = self?.faceModel?.billionth?.distinctionless
                let idstatus = distinctionlessModel?.hundredfold ?? 0
                let facestatus = distinctionlessModel?.hundredfold ?? 0
                if idstatus == 0 {
                    HudToastView.showMessage(with: "Complete identity verification first.")
                }else if facestatus == 0 {
                    self?.alertFaceView()
                }else if facestatus == 1 {
                    HudToastView.showMessage(with: "Identity verification completed.")
                }
            }).disposed(by: disposeBag)
        
        getFaceInfo()
    }
    
}

extension FaceViewController {
    
    private func getFaceInfo() {
        let json = ["snowier": productID, "curb": type]
        Task {
            do {
                let model = try await viewModel.findFacelInfo(with: json)
                self.faceModel = model
                
                let photoModel = model.billionth?.distinctionless
                let faceModel = model.billionth?.photometrically
                
                let photostatus = photoModel?.hundredfold ?? 0
                let facestatus = faceModel?.hundredfold ?? 0
                
                if photostatus == 0 {
                    alertPhotoView()
                }else if facestatus == 0 {
                    alertFaceView()
                }else {
                    
                }
            } catch  {
                
            }
        }
    }
    
    private func alertPhotoView() {
        let photoView = ChoosePhotoView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: photoView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        photoView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        photoView.cameraBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPickerManager.shared.takePhoto(from: self) { image in
                    guard let image = image else { return }
                    self.upLoadPhotoImageInfo(with: "1", image: image)
                }
            }
        }
        
        photoView.photoBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                AlbumPickerManager.shared.pickImage(from: self) { image in
                    guard let image = image else { return }
                    self.upLoadPhotoImageInfo(with: "2", image: image)
                }
            }
        }
    }
    
    private func alertFaceView() {
        HudToastView.showMessage(with: "face")
    }
    
    private func upLoadPhotoImageInfo(with cratemen: String, image: UIImage) {
        let json = ["cratemen": cratemen, "frypans": "11", "metabiological": type]
        Task {
            do {
                let model = try await faceViewModel.uploadImageInfo(with: json, image: image)
                if model.phacotherapy == "0" {
                    
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
    }
    
}

