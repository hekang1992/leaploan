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
import Kingfisher

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
    
    /// INSERT_VIEW_MODEL_MESSAGE_INFO
    let misassertViewModel = MisassertViewModel()
    
    var one: String = ""
    var two: String = ""
    
    var three: String = ""
    var four: String = ""
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setTitle("Next Step", for: .normal)
        clickBtn.backgroundColor = UIColor.init(hexString: "#FF29D5")
        clickBtn.setTitleColor(.white, for: .normal)
        clickBtn.layer.cornerRadius = 22
        clickBtn.layer.masksToBounds = true
        clickBtn.isHidden = true
        return clickBtn
    }()
    
    let locationManager = AppLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationManager.getCurrentLocation { model in
            LocationManagerModel.shared.model = model
        }
        
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
        
        stepHeadView.configWithModelArray(with: baseModel?.billionth?.gadgeteer ?? [], selectIndex: 0)
        
        view.addSubview(faceUploadView)
        faceUploadView.snp.makeConstraints { make in
            make.top.equalTo(stepHeadView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 321, height: 44))
            make.centerX.equalToSuperview()
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
                let photometricallyModel = self?.faceModel?.billionth?.photometrically
                let idstatus = distinctionlessModel?.hundredfold ?? 0
                let facestatus = photometricallyModel?.hundredfold ?? 0
                if idstatus == 0 {
                    self?.alertPhotoView()
                }else if facestatus == 0 {
                    self?.alertFaceView()
                    self?.three = String(Int(Date().timeIntervalSince1970))
                }else if facestatus == 1 {
                    HudToastView.showMessage(with: "Identity verification completed.")
                }
            }).disposed(by: disposeBag)
        
        clickBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.popAuthListVC()
        }).disposed(by: disposeBag)
        
        getFaceInfo()
        /// ONE_MESSAGE_TIME
        one = String(Int(Date().timeIntervalSince1970))
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
                
                
                let photoslogo = photoModel?.antisubversive ?? ""
                let faceslogo = faceModel?.antisubversive ?? ""
                let metabiological = photoModel?.metabiological ?? ""
                
                
                if photostatus == 0 {
                    alertPhotoView()
                    return
                }
                
                self.faceUploadView.photoListView.bgImageView.kf.setImage(with: URL(string: photoslogo))
                self.faceUploadView.photoListView.descImageView.image = UIImage(named: "check_sel_image")
                self.faceUploadView.nameLabel.text = metabiological
                
                if facestatus == 0 {
                    three = String(Int(Date().timeIntervalSince1970))
                    alertFaceView()
                    return
                }
                
                self.faceUploadView.faceListView.bgImageView.kf.setImage(with: URL(string: faceslogo))
                self.faceUploadView.faceListView.descImageView.image = UIImage(named: "check_sel_image")
                self.clickBtn.isHidden = false
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
                CameraPickerManager.shared.takePhoto(from: self, source: "1") { image in
                    guard let image = image else { return }
                    self.upLoadPhotoImageInfo(with: "1",frypans: "11", image: image)
                }
            }
        }
        
        photoView.photoBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                AlbumPickerManager.shared.pickImage(from: self) { image in
                    guard let image = image else { return }
                    self.upLoadPhotoImageInfo(with: "2",frypans: "11", image: image)
                }
            }
        }
    }
    
    private func alertFaceView() {
        let photoView = ChooseFaceView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: photoView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        photoView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        photoView.cameraBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                CameraPickerManager.shared.takePhoto(from: self, source: "2") { image in
                    guard let image = image else { return }
                    self.upLoadPhotoImageInfo(with: "1", frypans: "10", image: image)
                }
            }
        }
    }
    
    private func upLoadPhotoImageInfo(with cratemen: String, frypans: String, image: UIImage) {
        let json = ["cratemen": cratemen, "frypans": frypans, "metabiological": type]
        Task {
            do {
                let model = try await faceViewModel.uploadImageInfo(with: json, image: image)
                if model.phacotherapy == "0" {
                    if frypans == "11" {
                        alertWithModel(with: model)
                    }else {
                        self.four = String(Int(Date().timeIntervalSince1970))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
                            self.getFaceInfo()
                            
                            Task.detached { [weak self] in
                                guard let self = self else { return }
                                await self.insertMessageInfo(
                                    with: "4",
                                    onepera: three,
                                    twopera: four,
                                    threepera: "",
                                    viewModel: misassertViewModel
                                )
                            }
                        }
                    }
                }else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
            } catch  {
                
            }
        }
    }
    
    private func alertWithModel(with model: BaseModel) {
        two = String(Int(Date().timeIntervalSince1970))
        let selectNameView = SelectNameView(frame: self.view.bounds)
        let modelArray = model.billionth?.floroscope ?? []
        selectNameView.modelArray = modelArray
        let alertVc = TYAlertController(alert: selectNameView, preferredStyle: .actionSheet, transitionAnimation: .dropDown)!
        self.present(alertVc, animated: true)
        selectNameView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        selectNameView.clickBlock = { [weak self] in
            guard let self = self else { return }
            var json: [String: String] = ["metabiological": type,
                                          "frypans": "11",
                                          "snowier": productID]
            for model in modelArray {
                let key = model.phacotherapy ?? ""
                let value = model.operculiferous ?? ""
                json[key] = value
            }
            print("json===========\(json)")
            self.saveInfo(with: json)
        }
    }
    
    private func saveInfo(with json: [String: String]) {
        Task {
            do {
                let model = try await faceViewModel.saveImageInfo(with: json)
                
                if model.phacotherapy == "0" {
                    await MainActor.run { [weak self] in
                        guard let self = self else { return }
                        self.dismiss(animated: true) {
                            self.getFaceInfo()
                            
                            // fire-and-forget 埋点，不阻塞
                            Task.detached { [weak self] in
                                guard let self = self else { return }
                                await self.insertMessageInfo(
                                    with: "3",
                                    onepera: one,
                                    twopera: two,
                                    threepera: "",
                                    viewModel: misassertViewModel
                                )
                            }
                        }
                    }
                } else {
                    HudToastView.showMessage(with: model.marsi ?? "")
                }
                
            } catch {
                print("❌ saveInfo error: \(error)")
            }
        }
    }
    
    
    
}

