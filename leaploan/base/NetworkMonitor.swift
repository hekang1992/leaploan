//
//  Untitled.swift
//  leaploan
//
//  Created by hekang on 2025/11/12.
//

import Alamofire

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    var statusChanged: ((NetworkReachabilityManager.NetworkReachabilityStatus) -> Void)?
    
    func startListening() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            self?.statusChanged?(status)
        })
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
    }
}
