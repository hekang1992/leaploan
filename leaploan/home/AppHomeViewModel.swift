//
//  AppHomeViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

class AppHomeViewModel {
    
    func findHomeInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.get("/Pasteurella/whiba", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    func applyProductInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/uninitiative", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
}
