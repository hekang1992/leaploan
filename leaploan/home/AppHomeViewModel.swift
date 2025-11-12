//
//  AppHomeViewModel.swift
//  leaploan
//
//  Created by hekang on 2025/10/31.
//

import BRPickerView

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
    
    func getCityAddressInfo(with json: [String: String]) async throws -> BaseModel {
        
        Loading.show()
        
        defer {
            Loading.hide()
        }
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.get("/Pasteurella/coprincipals", parameters: json)
            if model.phacotherapy == "0" {
                let mankin = model.billionth?.mankin ?? []
                HomeAddressModel.shared.cityModelArray = AddressModel.getAddressModelArray(dataSourceArr: mankin)
            }
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    /// BACK_END_LOCATION_MESSAGE_INFO
    func backLocationendInfo(with json: [String: Any]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/louting", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
    func backDevAppInfo(with json: [String: Any]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await HttpsRequest.shared.postFrom("/Pasteurella/cosmometry", parameters: json)
            return model
        } catch {
            print("error===: \(error)")
            throw error
        }
    }
    
}


class HomeAddressModel {
    static let shared = HomeAddressModel()
    private init() {}
    var cityModelArray: [BRProvinceModel]?
}

