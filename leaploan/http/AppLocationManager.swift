//
//  AppLocationManager.swift
//  leaploan
//
//  Created by hekang on 2025/11/6.
//

import UIKit
import CoreLocation

struct SimpleLocation {
    let country: String?
    let countryCode: String?
    let province: String?
    let city: String?
    let district: String?
    let subLocality: String?
    let street: String?
    let address: String?
    let latitude: String?
    let longitude: String?
}

class AppLocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private var completion: ((SimpleLocation?) -> Void)?
    private var isUpdating = false
    private var hasReceivedLocation = false // 新增：标记是否已收到位置
    
    func getCurrentLocation(completion: @escaping (SimpleLocation?) -> Void) {
        // 重置状态
        self.hasReceivedLocation = false
        self.completion = completion
        
        let status = locationManager.authorizationStatus
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            return
        }
        startSingleLocationUpdate()
    }
}

extension AppLocationManager: CLLocationManagerDelegate {
    
    private func startSingleLocationUpdate() {
        guard !isUpdating else { return }
        
        isUpdating = true
        hasReceivedLocation = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    private func stopLocationUpdate() {
        isUpdating = false
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasReceivedLocation, let location = locations.last else { return }
        
        guard location.horizontalAccuracy >= 0 && location.horizontalAccuracy <= 100 else { return }
        
        hasReceivedLocation = true
        stopLocationUpdate()
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            let placemark = placemarks?.first
            
            let locationInfo = SimpleLocation(
                country: placemark?.country,
                countryCode: placemark?.isoCountryCode,
                province: placemark?.administrativeArea,
                city: placemark?.locality,
                district: placemark?.subAdministrativeArea,
                subLocality: placemark?.subLocality,
                street: placemark?.thoroughfare,
                address: placemark?.name,
                latitude: String(format: "%.6f", location.coordinate.latitude),
                longitude: String(format: "%.6f", location.coordinate.longitude)
            )
            
            self.completion?(locationInfo)
            self.completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stopLocationUpdate()
        if !hasReceivedLocation {
            hasReceivedLocation = true
            completion?(nil)
            completion = nil
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            hasReceivedLocation = false
            startSingleLocationUpdate()
        } else if status == .denied || status == .restricted {
            if !hasReceivedLocation {
                hasReceivedLocation = true
                completion?(nil)
                completion = nil
            }
        }
    }
}

class LocationManagerModel {
    static let shared = LocationManagerModel()
    private init() {}
    var model: SimpleLocation?
}
