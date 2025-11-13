//
//  DeviceManager.swift
//  leaploan
//
//  Created by hekang on 2025/11/6.
//

import UIKit
import Foundation
import SystemConfiguration
import CoreTelephony

class DeviceManager: NSObject {
    
    static func getRealDeviceData() -> String? {
        let deviceData: [String: Any] = [
            "souses": SystemInfo.infoStrings(),
            "irreparableness": DeviceInfoManager.getBatteryInfo(),
            "crewmen": DeviceInfoManager.getDeviceInfo(),
            "paraphrenia": DeviceInfoManager.getSecurityInfo(),
            "pelican": DeviceInfoManager.getSystemInfo(),
            "furlable": DeviceInfoManager.getWiFiInfo()
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: deviceData, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return ""
    }
    
}

class DeviceInfoManager {
    
    static func getBatteryInfo() -> [String: Int] {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full ? 1 : 0
        
        return [
            "riem": batteryLevel,
            "phytomonas": isCharging
        ]
    }
    
    static func getDeviceInfo() -> [String: String] {
        let device = UIDevice.current
        
        return [
            "suchta": device.systemVersion,
            "chador": "iPhone",
            "horney": getDeviceModel()
        ]
    }
    
    static func getSecurityInfo() -> [String: Int] {
        return [
            "unbrushed": isSimulator() ? 1 : 0,
            "digressory": isJailbroken() ? 1 : 0
        ]
    }
    
    static func getSystemInfo() -> [String: String] {
        return [
            "ardme": NSTimeZone.system.abbreviation() ?? "",
            "undersheriffwick": getIDFV(),
            "digiangi": Locale.preferredLanguages.first ?? "en",
            "interpaved": getNetworkType(),
            "soilier": getIDFA()
        ]
    }
    
    func getBssidInfo() -> (ssid: String?, bssid: String?) {
        var ssid: String?
        var bssid: String?
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return (nil, nil)
        }
        for interface in interfaces {
            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
                continue
            }
            
            ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
            bssid = interfaceInfo[kCNNetworkInfoKeyBSSID as String] as? String
            if ssid != nil || bssid != nil {
                break
            }
        }
        
        return (ssid, bssid)
    }
    
    static func getWiFiInfo() -> [String: Any] {
        let dict = DeviceInfoManager().getBssidInfo()
        return [
            "nonzonal": [
                "anathematism": dict.bssid ?? "",
                "unmalted": dict.ssid ?? ""
            ]
        ]
    }
    
    private static func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    private static func isSimulator() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    private static func isJailbroken() -> Bool {
        // 越狱检测逻辑
        let jailbrokenFilePaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        for path in jailbrokenFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        return false
    }
    
    private static func getIDFV() -> String {
        return GetDoubleIDManager.shared.getIDFV()
    }
    
    private static func getIDFA() -> String {
        return GetDoubleIDManager.shared.getIDFA()
    }
    
    private static func getNetworkType() -> String {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "https://www.apple.com") else {
            return "error"
        }
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if flags.contains(.isWWAN) {
            let networkInfo = CTTelephonyNetworkInfo()
            if let currentRadio = networkInfo.serviceCurrentRadioAccessTechnology?.values.first {
                switch currentRadio {
                case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                    return "2G"
                case CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyHSUPA, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB, CTRadioAccessTechnologyeHRPD:
                    return "3G"
                case CTRadioAccessTechnologyLTE:
                    return "4G"
                default:
                    return "5G"
                }
            }
            return "OTHER"
        } else if flags.contains(.reachable) {
            return "WIFI"
        } else {
            return "OTHER"
        }
    }
}

struct SystemInfo {
    
   static func getNewFreeSize() -> String {
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
        do {
            let resourceValues = try tempURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let availableCapacity = resourceValues.volumeAvailableCapacityForImportantUsage {
                return "\(availableCapacity)"
            } else {
                return "-1"
            }
        } catch {
            return "-1"
        }
    }
    
    static var totalDiskSpace: UInt64 {
        if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let totalSize = attributes[.systemSize] as? NSNumber {
            return totalSize.uint64Value
        }
        return 0
    }
    
    static var totalMemory: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
   static func getAvailableMemorySize() -> String {
        var vmStats = vm_statistics_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)

        let kernReturn = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics(mach_host_self(), HOST_VM_INFO, $0, &count)
            }
        }

        guard kernReturn == KERN_SUCCESS else {
            return "-1"
        }

        let pageSize = vm_kernel_page_size
        let availableMemory = Int64(pageSize) * Int64(vmStats.free_count + vmStats.inactive_count)

        return "\(availableMemory)"
    }
    
    static func infoStrings() -> [String: String] {
        let a = getNewFreeSize()
        let t = String(totalDiskSpace)
        let tm = String(totalMemory)
        let am = getAvailableMemorySize()

        return [
            "perinephrium": "\(a)",
            "catholicos": "\(t)",
            "periprostatitis": "\(tm)",
            "skewly": "\(am)"
        ]
    }
}
