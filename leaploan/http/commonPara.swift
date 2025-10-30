//
//  commonPara.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import UIKit
import DeviceKit
import AdSupport
import SAMKeychain
import AppTrackingTransparency

class commonPara: NSObject {
    
    var vallombrosan: String?
    var apozemical: String?
    var thermotensile: String?
    var fundy: String?
    var shavery: String?
    var braunstein: String?
    
    init(vallombrosan: String? = nil, apozemical: String? = nil, thermotensile: String? = nil, fundy: String? = nil, shavery: String? = nil, braunstein: String? = nil) {
        let current = Device.current
        self.vallombrosan = "1.0.0"
        self.apozemical = current.name
        self.thermotensile = GetDoubleIDManager.shared.getIDFV()
        self.fundy = current.systemVersion
        self.shavery = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.braunstein = GetDoubleIDManager.shared.getIDFA()
    }
    
    static func loginDictInfo() -> [String: String] {
        let para = commonPara()
        return ["vallombrosan": para.vallombrosan ?? "",
                "apozemical": para.apozemical ?? "",
                "thermotensile": para.thermotensile ?? "",
                "fundy": para.fundy ?? "",
                "shavery": para.shavery ?? "",
                "braunstein": para.braunstein ?? ""]
    }
    
}

class GetDoubleIDManager {
    
    static let shared = GetDoubleIDManager()
    
    private let serviceName = "ll.leaploan.com"
    private let accountName = "leaploan"
    
    private enum KeychainError: Error {
        case notFound
        case accessFailed
    }
    
    func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    func getIDFV() -> String {
        if let existingID = try? retrieveIDFromKeychain() {
            return existingID
        }
        let getNewID = generateNewID()
        storeIDInKeychain(getNewID)
        return getNewID
    }
    
    private func retrieveIDFromKeychain() throws -> String {
        if let deviceID = SAMKeychain.password(forService: serviceName, account: accountName) {
            return deviceID
        }
        throw KeychainError.notFound
    }
    
    private func generateNewID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    private func storeIDInKeychain(_ id: String) {
        let success = SAMKeychain.setPassword(id, forService: serviceName, account: accountName)
        if !success {
            print("Failed to store device ID in keychain")
        }
    }

}

class ParameterToUrlConfig {
    static func appendQuery(to url: String, parameters: [String: String]) -> String? {
        guard var components = URLComponents(string: url) else { return nil }
        
        let newItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = (components.queryItems ?? []) + newItems
        
        return components.url?.absoluteString
    }
}

class AppTitleConfig {
    
    static let settting_title = "Settings"
    
}
