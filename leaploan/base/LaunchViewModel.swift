//
//  LaunchViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

class LaunchViewModel {
    
    func initLaunchInfo(with json: [String: Any]) async throws -> BaseModel {
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/digiangi", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
        
    }
    
    func toAppleMarket(with json: [String: String]) async throws -> BaseModel {
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/nighted", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}
