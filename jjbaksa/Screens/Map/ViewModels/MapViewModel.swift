//
//  MapViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/10.
//

import Foundation
import CoreLocation

class MapViewModel: NSObject, ObservableObject {
    @Published var isNearbyStoreShow: Bool = false
    @Published var isFriendStoreShow: Bool = false
    @Published var isBookMarkStoreShow: Bool = false
    
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


