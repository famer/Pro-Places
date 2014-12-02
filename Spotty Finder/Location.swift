//
//  Location.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 23.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var altitude: CLLocationDistance = 0.0
    var horizontalAccuracy: CLLocationAccuracy = 0.0
    var verticalAccuracy: CLLocationAccuracy = 0.0
    var date: NSDate = NSDate()
    var location: CLLocation {
        get {
            return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, timestamp: date)
        }
        set (location) {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            horizontalAccuracy = location.horizontalAccuracy
            verticalAccuracy = location.verticalAccuracy
            date = location.timestamp
            altitude = location.altitude
        }
    }
    
    init () {}
    
    init ( location: CLLocation ) {
        self.location = location
    }
    
    var asText: String {
        return String(format: "%.4f, %.4f", location.coordinate.latitude, location.coordinate.longitude)
        //return "\(location.coordinate.latitude) \(location.coordinate.longitude)"
    }
}