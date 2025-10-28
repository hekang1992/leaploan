//
//  loginAuthManager.swift
//  leaploan
//
//  Created by hekang on 2025/10/28.
//

import Foundation

class LoginAuthManager {
    
    private enum UserDefaultsKey {
        static let phone = "phone"
        static let token = "token"
    }
    
    private static let userDefaults = UserDefaults.standard
    
    static func saveLoginInfo(with phone: String, token: String) {
        userDefaults.set(phone, forKey: UserDefaultsKey.phone)
        userDefaults.set(token, forKey: UserDefaultsKey.token)
        userDefaults.synchronize()
    }
    
    static func removeLoginInfo() {
        userDefaults.removeObject(forKey: UserDefaultsKey.phone)
        userDefaults.removeObject(forKey: UserDefaultsKey.token)
    }
    
    static var isLoggedIn: Bool {
        return !phoneNumber.isEmpty
    }
    
    static var phoneNumber: String {
        return userDefaults.string(forKey: UserDefaultsKey.phone) ?? ""
    }
    
    static var token: String? {
        return userDefaults.string(forKey: UserDefaultsKey.token)
    }
    
    static var authInfo: (phone: String, token: String)? {
        guard let token = token, !phoneNumber.isEmpty else {
            return nil
        }
        return (phoneNumber, token)
    }
}
