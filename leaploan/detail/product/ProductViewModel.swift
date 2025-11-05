//
//  ProductViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import Combine

class ProductViewModel {
    
    func findProductDetailInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/fructoses", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    
    /// GET_FACE_INFO
    func findFacelInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/accidentalness", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    /// DUE_ORDER_MESSAGE
    func dueOrderInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/harkening", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}



class RouterConfig {
    static let ONE_AUTH_STEP = "Rhoecus"
    static let TWO_AUTH_STEP = "stanchly"
    static let THREE_AUTH_STEP = "tribade"
    static let FOUR_AUTH_STEP = "mortgages"
    static let FIVE_AUTH_STEP = "Scotsmen"
    static let SIX_AUTH_STEP = ""
}
