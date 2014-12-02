//
//  NamedPlace.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 16.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class NamedPlace: Place {
    var name: String? 
    
    var title: String {
        if let notNilName = name {
            return notNilName
        } else {
            return formattedDate()
        }
    }

    var subtitle: String {
        return "\(location.asText)"
    }
    
    init(name: String?, Lat: CLLocationDegrees, Lon: CLLocationDegrees) {
        self.name = name
        super.init(Lat: Lat, Lon: Lon)
    }
    
    init(name: String? = nil, location: CLLocation) {
        self.name = name
        super.init(location: location)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.idInArray = aDecoder.decodeObjectForKey("idInArray") as? Int
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.image = UIImage(data:(aDecoder.decodeObjectForKey("image") as NSData))!
        self.location.latitude = aDecoder.decodeObjectForKey("latitude") as CLLocationDegrees
        self.location.longitude = aDecoder.decodeObjectForKey("longitude") as CLLocationDegrees
        self.location.date = aDecoder.decodeObjectForKey("date") as NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.idInArray, forKey: "idInArray")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(UIImagePNGRepresentation(self.image), forKey: "image")
        aCoder.encodeObject(self.latitude, forKey: "latitude")
        aCoder.encodeObject(self.longitude, forKey: "longitude")
        aCoder.encodeObject(self.date, forKey: "date")
    }
    
    var annotationViewVar: NamedPlaceAnnotationView?
    
    func annotationView() -> MKAnnotationView {
        
        if let aView = annotationViewVar {
            return aView
        }
        annotationViewVar = NamedPlaceAnnotationView(annotation: self, reuseIdentifier: reuseId)
        return annotationViewVar!
    }

    
}
