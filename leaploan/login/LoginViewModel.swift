//
//  LoginViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

class LoginViewModel {
    
    func findCodeInfo(with json: [String: String]) async throws -> BaseModel {
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/phlebotomic", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    
    
}
