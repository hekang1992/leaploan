//
//  PersonalViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

class PersonalViewModel {
    
    
    /// SAVE_IMAGE_INFO_CDC
    func getPersonalInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/snookers", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    func savePersonalInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/inflictable", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}
