//
//  Untitled.swift
//  leaploan
//
//  Created by hekang on 2025/11/4.
//

class ConactCheckViewModel {
    
    /// SAVE_IMAGE_INFO_CDC
    func getPersonalInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/dispender", parameters: json)
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
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/poinder", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    ///UP_LOAD_PHONES_INFO
    func uploadPhonesInfo(with json: [String: String]) async throws -> BaseModel {
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/prebendaries", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    func savePhonesInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/poinder", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
}
