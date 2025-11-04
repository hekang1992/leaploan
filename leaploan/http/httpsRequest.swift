//
//  httprequest.swift
//  PeraLend
//
//  Created by hekang on 2025/7/21.
//

import Foundation
import Alamofire
import UIKit
import SnapKit

struct API {
    static let baseURL = "http://47.84.60.25:8590/Mithraeums"
    static let schemeURL = "Or://on.rs.ec"
    static let schemeURL_setting = "Or://on.rs.ec/Acontias"
    static let schemeURL_home = "Or://on.rs.ec/unfleshed"
    static let schemeURL_login = "Or://on.rs.ec/trigly"
    static let schemeURL_order = "Or://on.rs.ec/likelihoods"
    static let schemeURL_product_detail = "Or://on.rs.ec/mediastinum"
}

final class HttpsRequest {
    static let shared = HttpsRequest()
    private init() {}
}

extension HttpsRequest {
    
    func get<T: Decodable>(_ path: String,
                           parameters: [String: Any]? = nil) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            let url = API.baseURL + path
            let api = ParameterToUrlConfig.appendQuery(to: url, parameters: commonPara.loginDictInfo()) ?? ""
            AF.request(api, method: .get, parameters: parameters)
                .validate()
                .responseDecodable(of: T.self, queue: .global()) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func post<T: Decodable>(_ path: String,
                            parameters: [String: Any]? = nil) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            let url = API.baseURL + path
            let api = ParameterToUrlConfig.appendQuery(to: url, parameters: commonPara.loginDictInfo()) ?? ""
            AF.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: T.self, queue: .global()) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func postFrom<T: Decodable>(_ path: String,
                                parameters: [String: Any]? = nil) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            let url = API.baseURL + path
            let api = ParameterToUrlConfig.appendQuery(to: url, parameters: commonPara.loginDictInfo()) ?? ""
            AF.upload(multipartFormData: { formData in
                parameters?.forEach { key, value in
                    if let data = "\(value)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }, to: api, method: .post)
            .validate()
            .responseDecodable(of: T.self, queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func upload<T: Decodable>(_ path: String,
                              image: UIImage,
                              parameters: [String: Any]? = nil) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            let url = API.baseURL + path
            let api = ParameterToUrlConfig.appendQuery(to: url, parameters: commonPara.loginDictInfo()) ?? ""
            AF.upload(multipartFormData: { formData in
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(imageData,
                                    withName: "froideur",
                                    fileName: "upload.jpg",
                                    mimeType: "image/jpeg")
                }
                parameters?.forEach { key, value in
                    if let data = "\(value)".data(using: .utf8) {
                        formData.append(data, withName: key)
                    }
                }
            }, to: api, method: .post)
            .validate()
            .responseDecodable(of: T.self, queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


final class Loading {
    static let shared = Loading()
    
    private var loadingView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    static func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            
            if shared.loadingView != nil { return }
            
            let backgroundView = UIView(frame: window.bounds)
            backgroundView.backgroundColor = UIColor.clear
            
            
            let bgView = UIView()
            bgView.backgroundColor = .darkGray
            bgView.layer.cornerRadius = 20
            bgView.clipsToBounds = true
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.center = backgroundView.center
            indicator.startAnimating()
            
            backgroundView.addSubview(bgView)
            bgView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: 80, height: 80))
            }
            
            backgroundView.addSubview(indicator)
            window.addSubview(backgroundView)
            
            shared.loadingView = backgroundView
            shared.activityIndicator = indicator
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            shared.activityIndicator?.stopAnimating()
            shared.loadingView?.removeFromSuperview()
            
            shared.activityIndicator = nil
            shared.loadingView = nil
        }
    }
}

