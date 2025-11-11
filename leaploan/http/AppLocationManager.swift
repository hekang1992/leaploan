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
    
    private var debounceWorkItem: DispatchWorkItem?
    private let debounceInterval: TimeInterval = 2.0
    
    func getCurrentLocation(completion: @escaping (SimpleLocation?) -> Void) {
        self.completion = completion
        
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdate()
            
        case .denied, .restricted:
            completion(nil)
            
        @unknown default:
            completion(nil)
        }
    }
    
    private func startLocationUpdate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
}

extension AppLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard location.horizontalAccuracy >= 0 && location.horizontalAccuracy <= 100 else { return }
        
        locationManager.stopUpdatingLocation()
        
        debounceWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
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
                
                self?.completion?(locationInfo)
            }
        }
        
        debounceWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval, execute: workItem)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        completion?(nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startLocationUpdate()
        } else if status == .denied || status == .restricted {
            completion?(nil)
        }
    }
}


class LocationManagerModel {
    static let shared = LocationManagerModel()
    private init() {}
    var model: SimpleLocation?
}
