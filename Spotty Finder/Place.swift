//
//  Place.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 15.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    
    //let locationSource: LocationSource = GeoLocationSource;
    let reuseId = "pin"
    
    var idInArray: Int?
    
    var location: Location = Location()
    
    var latitude: CLLocationDegrees {
        return location.latitude
    }
    var longitude: CLLocationDegrees {
        return location.longitude
    }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var date: NSDate {
        return location.date
    }
    
    var sendMessageFormat: String {
        let path: String = NSBundle.mainBundle().pathForResource("Info", ofType:"plist")!
        let data = NSDictionary(contentsOfFile: path)!
        return data.valueForKey("Send location message scheme") as String
    }
    
    var image: UIImage = UIImage(named: "house.png")!

    override init() {}
    
    init(location: CLLocation) {
        self.location = Location(location: location)
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // FIXIT: make location and use previous init
        self.location.latitude = latitude
        self.location.longitude = longitude
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.location.latitude = newCoordinate.latitude;
        self.location.longitude = newCoordinate.longitude;
    }
    
    func equal(place: Place) -> Bool {
        if self.latitude == place.latitude && self.longitude == place.longitude {
            return true
        }
        return false
    }
    
    func formattedDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a"
        return dateFormatter.stringFromDate(date)
    }
    
    func sendMessage(#type: Int) -> String {
        switch type {
        case 0:
            return String(format: sendMessageFormat, latitude, longitude)
        default:
            return String(format: sendMessageFormat, latitude, longitude)
        }
        
    }
    
}
