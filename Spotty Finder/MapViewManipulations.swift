//
//  MapViewHelper.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 19.11.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import MapKit

class MapViewManipulations {

    let navigation: Navigation = Navigation.sharedInstance
    var overView = false
    let numbers = (pointFour: 0.4, pointEight: 0.8, floatTwo: 2.0)
    let piGrad: Double = 180.0
    let pi2XGrad: Double = 360.0
    let metersPerMile = 1609.344
    let maxVisibleDistance = 141.0
    let annotationWidth: Double = 38.0
    
    
    
    var mapWidth: Double {
        return Double(self.mapKitView.frame.width)
    }
    
    
    var animatingMap = false
    var interactingMap = false
    
    
    var mapKitView: MKMapView
    var dummyMapView: MKMapView //frame: mapKitView.frame
    
    func addAnnotations() {
        mapKitView.addAnnotations(navigation.places.stored)
    }
    
    init() {
        mapKitView = MKMapView()
        dummyMapView = MKMapView()
    }
    
    init (mmapKitView: MKMapView) {
        mapKitView = mmapKitView
        dummyMapView = MKMapView(frame: mapKitView.frame)
    }
    
    func updateMapUI() {
        
        if (self.animatingMap) {
            return
        }
        
        dummyMapView.frame = mapKitView.frame
        
        if ( navigation.places.target != nil && !overView ) {
            var zoomLocation = navigation.currentLocation!.coordinate
            
            
            let Distance = navigation.distanceTo()!
            var delta = ( Distance * numbers.floatTwo / mapWidth ) * annotationWidth; // 38 / 2 --  half of size of target spot image
            
            var viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, numbers.pointEight * metersPerMile, numbers.pointEight * metersPerMile);
            
            if (  Distance > maxVisibleDistance) {
                viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, Distance * numbers.floatTwo + delta, Distance * numbers.floatTwo + delta);
            } else {
                viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, maxVisibleDistance * numbers.floatTwo, maxVisibleDistance * numbers.floatTwo);
            }
            
            dummyMapView.region = viewRegion;
            
            /*
            7.379393 is a some some constant calculated practicaly
            double altitude; if (Distance> MAX_VISIBLE_DISTANCE ) {        altitude = Distance*7.379393;    } else {        altitude = MAX_VISIBLE_DISTANCE * 7.379393;    }
            */
            
        } else {
            dummyMapView.showAnnotations(mapKitView.annotations, animated: false)
            dummyMapView.camera.altitude *= 2 
        }
        
        if navigation.locationSource.currentHeading < piGrad {
            dummyMapView.camera.heading = navigation.locationSource.currentHeading
        } else {
            dummyMapView.camera.heading = navigation.locationSource.currentHeading - pi2XGrad
        }
        dummyMapView.camera.centerCoordinate = navigation.currentLocation!.coordinate

        
        /*
        in case for letting map to animate by itself
        self.mapKitView.camera.animationDidStop(<#anim: CAAnimation!#>, finished: <#Bool#>)
        self.mapKitView.setCamera(camera, animated: true)
        */
        
        //self.mapKitView.camera.animationDidStop(<#anim: CAAnimation!#>, finished: <#Bool#>)
        //self.mapKitView.setCamera(dummyMapView.camera, animated: true)
        //self.animatingMap = true
        
        
        UIView.animateWithDuration(numbers.pointFour, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveLinear | UIViewAnimationOptions.AllowUserInteraction , animations:
            {
                if !self.animatingMap && !self.interactingMap {
                    self.animatingMap = true
                    self.mapKitView.camera = self.dummyMapView.camera.copy() as MKMapCamera
                } else {
                    // println("animating")
                }
            }
            , completion: { finished in
                self.animatingMap = false
        })
        
        
        
        
    }
}
