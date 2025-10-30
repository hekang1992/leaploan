//
//  SettingViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/30.
//

class SettingViewModel {
    
    func settingRequestApi(with type: String) async throws -> BaseModel {
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        var pageUrl: String = ""
        
        pageUrl = type == "1" ? "/Pasteurella/quechuas" : "/Pasteurella/photodrama"
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.get(pageUrl)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
        
    }
    
    
}
