//
//  LocationManager.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    private(set) var subLocality: String?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    private func lookUpCurrentLocation(lastLocation: CLLocation, completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastLocation,
                                        completionHandler: { (placemarks, error) in
                                            if error == nil {
                                                let firstLocation = placemarks?[0]
                                                completionHandler(firstLocation)
                                            }
                                            else {
                                                completionHandler(nil)
                                            }
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else { return }
        lookUpCurrentLocation(lastLocation: last) { placeMark in
            guard let placeMark = placeMark else { return }
            self.subLocality = placeMark.subLocality
        }
    }
}

