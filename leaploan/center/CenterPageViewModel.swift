//
//  CenterPageViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/29.
//

class CenterPageViewModel {
    
    func refreshCenterApi(with json: [String: Any]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.get("/Pasteurella/unworthily", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
        
    }
    
}
