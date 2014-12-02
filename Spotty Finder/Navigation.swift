//
//  Navigation.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 16.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import CoreLocation

class Navigation {
    
    class var sharedInstance : Navigation {
        struct Static {
            static let instance : Navigation = Navigation()
        }
        return Static.instance
    }
    
    let locationSource: LocationSource = LocationSource()
    var currentLocation: CLLocation? {
        return self.locationSource.currentLocation
    }
    var currentHeading: Double {
        return self.locationSource.currentLocation!.course
    }
    var places = PlacesSet();
    var delegate: MapViewManipulations?
    
    init() {
        locationSource.delegate = self
    }
  
    
    func setTarget(place: NamedPlace? = nil) {
        
        if (place != nil) {
            if place == places.target {
                return
            }
            places.target = place
        } else {
            if let activeCurrentLocation = currentLocation {
                places.target = NamedPlace(location: activeCurrentLocation)
            } else {
                println("no location")
            }
        }
    }
    
    func removeTarget() {
        places.target = nil
    }
    
    func distanceTo(place: NamedPlace? = nil) -> CLLocationDistance? {
        if let activeCurrentLocation = currentLocation {
            if place != nil {
                return activeCurrentLocation.distanceFromLocation(place!.location.location)
            } else if places.target != nil {
                return activeCurrentLocation.distanceFromLocation(places.target!.location.location)
            }
        }
        return nil
    }
    
    func locationUpdated(location: CLLocation) {
        //self.currentLocation = location;
        delegate?.updateMapUI()
    }
    
    func print() {
        for i in places.stored {
            println(i.idInArray)
        }
    }

}