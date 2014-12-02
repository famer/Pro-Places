//
//  LocationSource.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 16.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationSource: NSObject, CLLocationManagerDelegate  {
    
    let locationManager = CLLocationManager()
    
    var currentLatitude: CLLocationDegrees = 0.0
    var currentLongitude: CLLocationDegrees = 0.0
    var currentAltitude: CLLocationDistance = 0.0
    var currentHorizontalAccuracy: CLLocationAccuracy = 0.0
    var currentHeading: CLLocationDirection = 0.0
    
    var delegate: Navigation?
    
    var currentLocation: CLLocation? {
        return locationManager.location
        
        //return CLLocation(latitude: currentLatitude, longitude: currentLongitude)
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.headingFilter = 2
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentHorizontalAccuracy = manager.location.horizontalAccuracy
        currentAltitude = manager.location.altitude
        currentLatitude = manager.location.coordinate.latitude
        currentLongitude = manager.location.coordinate.longitude
        
        //delegate?.locationUpdated(manager.location)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        currentHeading = newHeading.trueHeading
        delegate?.locationUpdated(manager.location)
    }
    
}