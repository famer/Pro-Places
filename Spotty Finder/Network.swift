//
//  Network.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 28.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation

class Network {
    
    let navigation: Navigation = Navigation.sharedInstance
    var delegate: MapViewManipulations?
    
    func loadPlaces(key: String) {
        // some network request in block with call back
        // (data) -> {
        // navigation.places.update(data)
        // -delegate?.updatePlaces(navigation.places.stored)
        
    }
    
    func savePlaces(key: String, data: String) -> Bool {
        return true
    }
    
    func changePlace(key: String, data: String) {
        
    }
    
    func sendPlace(key: String, data: String, receiver: String) {
        
    }
}