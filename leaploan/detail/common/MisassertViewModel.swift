//
//  MisassertViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/11/6.
//

class MisassertViewModel {
    
    func insertMessageInfo(with json: [String: String]) async throws -> BaseModel {
        var allJson = ["nicotinian": "2",
                       "beperiwigged": GetDoubleIDManager.shared.getIDFV(),
                       "unpurgeable": GetDoubleIDManager.shared.getIDFA()]
        allJson.merge(json) { (_, new) in new }
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/misassert", parameters: allJson)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}
