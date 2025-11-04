//
//  FaceViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/11/2.
//

import UIKit

class FaceViewModel {
    
    /// UPLOAD_IMAGE_INFO_CDC
    func uploadImageInfo(with json: [String: String], image: UIImage) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.upload("/Pasteurella/gulash", image: image, parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}
