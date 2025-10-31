//
//  OrderListViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

class OrderListViewModel {
    
    func getOrderListInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/joleen", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    
}
