//
//  httprequest.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import Foundation
import Alamofire
import UIKit

struct API {
    static let baseURL = "http://47.84.60.25:8590/Mithraeums"
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
                                    withName: "file",
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
