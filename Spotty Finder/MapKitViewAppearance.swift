//
//  MapKitViewAppearance.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 26.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import MapKit

class MapKitViewAppearance: NSObject, MKMapViewDelegate {
    
    var uiView: ViewController?
    let placeActionSheetAppearance = PlaceActionSheetAppearance()
    
    override init() {}
    func setView(view: ViewController) {
        self.uiView = view
    }
    
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            if annotation.isKindOfClass(NamedPlace) {
                
                let placeAnnotation = annotation as NamedPlace
                /*
                var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(placeAnnotation.reuseId)
                if (annotationView == nil) {
                    annotationView = placeAnnotation.annotationView()
                } else {
                    annotationView.annotation = annotation
                }
                return annotationView
                */
                return placeAnnotation.annotationView()
            }
            return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            
            let placeToWorkWith = annotationView.annotation as NamedPlace
            
            
            placeActionSheetAppearance.setUIView(self.uiView!)
            placeActionSheetAppearance.setPlace(placeToWorkWith)
            placeActionSheetAppearance.setSheet()
            placeActionSheetAppearance.showSheet()
            
        } else if control == annotationView.leftCalloutAccessoryView {
            uiView?.placeImageSelectorView.hidden = !(uiView!.placeImageSelectorView.hidden)
            uiView?.annotationViewSelected = annotationView
        }
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        uiView?.placeImageSelectorView.hidden = true
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        self.uiView?.navigation.setTarget(place: (view.annotation as NamedPlace))
        self.uiView?.mapViewManipulations.updateMapUI()
    }
    
    func mapView(mapView: MKMapView!, didAddAnnotationViews views: [AnyObject]!) {
        if let currentPositionAnnotationView = mapView.viewForAnnotation(mapView.userLocation) {
            currentPositionAnnotationView.enabled = false
        }
    }
    
    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        //uiView?.mapViewManipulations.animatingMap = true
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        //uiView?.mapViewManipulations.animatingMap = false
    }
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        
        if newState == MKAnnotationViewDragState.None {
            return
        }
        let draggingAnnotation = (newState == MKAnnotationViewDragState.Starting)
            || (newState == MKAnnotationViewDragState.Dragging)
        
        self.uiView?.mapViewManipulations.interactingMap = draggingAnnotation
        if draggingAnnotation {
            self.uiView?.removePlaceSpace.hidden = !draggingAnnotation
        }
        
        //view.willMoveToSuperview(self.uiView?.removePlaceSpace)
        
        //var hitView = self.uiView?.removePlaceSpace.pointInside(view.center, withEvent: nil)
        
        
        
        if ( newState == MKAnnotationViewDragState.Ending ) {
            //view.dragState = MKAnnotationViewDragState.None 
            view.setDragState(MKAnnotationViewDragState.None, animated: false)
            let boundsA = view.convertRect(view.bounds, toView: nil)
            let boundsB = self.uiView!.removePlaceSpace.convertRect(self.uiView!.removePlaceSpace.bounds, toView: nil)
            let viewsOverlap = CGRectIntersectsRect(boundsA, boundsB)
            
            if (viewsOverlap) {
                
                self.uiView!.mapKitView.removeAnnotation(view.annotation)
                let placeToWorkWith = view.annotation as Place
                println(placeToWorkWith.idInArray)
                //self.uiView!.navigation.places.deletePlace((view.annotation as Place).idInArray)
                UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveLinear , animations:
                    {
                        self.uiView!.removePlaceSpace.alpha = 0.5
                    }, completion: { finished in
                        self.uiView!.removePlaceSpace.hidden = !draggingAnnotation
                        self.uiView!.removePlaceSpace.alpha = 1
                })
                
            } else {
                self.uiView?.removePlaceSpace.hidden = !draggingAnnotation
            }
            
        }
        println("Drag changed", newState.rawValue, newState.hashValue)
    }
    
    
}
