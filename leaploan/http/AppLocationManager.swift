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
    
    func getCurrentLocation(completion: @escaping (SimpleLocation?) -> Void) {
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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    private func stopLocationUpdate() {
        isUpdating = false
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        stopLocationUpdate()
        
        guard let location = locations.last else {
            completion?(nil)
            return
        }
        
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
            
            self.completion?(locationInfo)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stopLocationUpdate()
        completion?(nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startSingleLocationUpdate()
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
