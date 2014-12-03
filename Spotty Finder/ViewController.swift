//
//  ViewController.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 15.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var removePlaceSpace: UIView!
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var showMenuButton: UIButton!
    @IBOutlet weak var showSideBarMenuBarButton: UIBarButtonItem!
    @IBOutlet weak var placeImageSelectorView: ImageSelectorScrollView!
    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    
    
    let navigation = Navigation.sharedInstance
    let mapKitViewAppearance = MapKitViewAppearance()
    
    var mapViewManipulations = MapViewManipulations()
    
    let messageComposer = MessageComposer()
    let programmaticallyCreatedUI = ProgrammaticallyCreatedUI()
    let placeImageNames = ["house.png", "car.png", "house.png"] // "fishing.png", "car.png"]
    var annotationViewSelected: MKAnnotationView?
    var openUrl: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        mapKitView.showsUserLocation = true
        mapKitViewAppearance.setView(self)
        programmaticallyCreatedUI.uiView = self
        mapKitView.delegate = mapKitViewAppearance
        mapViewManipulations =  MapViewManipulations(mmapKitView: mapKitView)
        
        navigation.delegate = mapViewManipulations
        
        
        //mapKitView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        mapKitView.rotateEnabled = false
        //mapKitView.scrollEnabled = false
        
        let place1 = NamedPlace(name: "Yay1", latitude: 50.088611, longitude: 14.421389)
        //navigation.places.addPlace(place1)
        
        //navigation.print()
        
        let place2 = NamedPlace(name: "Yay", latitude: 51.088611, longitude: 14.421389) //NamedPlace(name: "Some yay", Lat: 12.12, Lon: 43.11)
        //navigation.places.addPlace(place2)
        
        let place3 = NamedPlace(name: "Yay3", latitude: 52.088611, longitude: 14.421389) //NamedPlace(name: "Some yay", Lat: 12.12, Lon: 43.11)
        
        //place2.image = UIImage(named: "car.png")!
        //navigation.places.update([place2, place3])
        
        //navigation.places.clearState()
        navigation.places.loadState()
        

        
        let place = NamedPlace(name: "Goal", latitude: 48.149111, longitude: 11.560991)
        let berlin = NamedPlace(name: "Berlin", latitude: 52.518302, longitude: 13.418957)
        navigation.places.update([place, berlin])
                
        createButtons(placeImageNames)
        
        mapViewManipulations.addAnnotations()
        self.view.addSubview(programmaticallyCreatedUI.overviewButton())
        
        self.showMenuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
        showSideBarMenuBarButton.target = self.revealViewController()
        showSideBarMenuBarButton.action = "revealToggle:"
        
        sendBarButton.target = self
        sendBarButton.action = "sendTextMessageButtonTapped:"
        
        //showMenuButton.target = self.revealViewController
        //showMenuButton.action = self.revealViewController().revealToggle() // @selector(revealToggle:);
        self.revealViewController().rearViewRevealOverdraw = 0.0
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    
    func createButtons(names: [String]) {
        for imageName in names {
            createButton(imageName)
        }
    }
    
    func createButton(imageName: String) {
        let imageButton = ImageChooserButton()
        imageButton.imageName = imageName
        imageButton.layer.cornerRadius = 10.0
        imageButton.clipsToBounds = true
        
        let image = UIImage(named: imageName)!
        imageButton.setBackgroundImage(image, forState:UIControlState.Normal)
        imageButton.addTarget(self, action: "imageChoosen:", forControlEvents: .TouchUpInside)
        self.placeImageSelectorView.addItem(imageButton)
    }
    
    @IBAction func imageChoosen(sender: AnyObject) {
        let imageName = (sender as ImageChooserButton).imageName
        let image = UIImage(named: imageName)!
        self.annotationViewSelected!.image = image
        navigation.places.saveState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePlace(sender: AnyObject) {
        navigation.setTarget()
        mapKitView.addAnnotation(navigation.places.target)
    }
    
    @IBAction func deletePlace(sender: AnyObject) {
        mapKitView.removeAnnotation(navigation.places.target)
        navigation.removeTarget()
    }

    @IBAction func namePlace(sender: AnyObject) {
        namedPlace("ASDF", i: 0)
        
    }
    
    func namedPlace(name: String, i: Int) {
        if let pPlace = navigation.places.stored[i] as? NamedPlace {
            (navigation.places.stored[i] as NamedPlace).name = name
        } else {
            var pPlace = navigation.places.stored[i]
            navigation.places.stored[i] = NamedPlace(name: name, latitude: pPlace.latitude, longitude: pPlace.longitude)
        }
        updateAnnotations()
    }
    @IBAction func showRemoved(sender: AnyObject) {
        self.performSegueWithIdentifier("Show Places", sender:self)
    }
    
    
    
    @IBAction func showPlaces() {
        
        
        if mapKitView.annotations.count - 1 /* minus current location marker */ > 1 {
            mapKitView.removeAnnotations(mapKitView.annotations)
            mapKitView.addAnnotation(navigation.places.target)
            
        } else {
            mapKitView.addAnnotations(navigation.places.stored)
        }
    }
    
    @IBAction func sendPlace(sender: AnyObject) {
    }
    
    
    func updateAnnotations() {
        mapKitView.removeAnnotations(mapKitView.annotations)
        mapKitView.addAnnotations(navigation.places.stored)
        if let target = navigation.places.target {
            mapKitView.addAnnotation(navigation.places.target)
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Places" {
            //(segue.destinationViewController as TableViewController).navigation = self.navigation
        }
        println(segue.identifier)
    }
    
    func config() {
        UIApplication.sharedApplication().idleTimerDisabled = false
        UIApplication.sharedApplication().idleTimerDisabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appDidBecomeActive:", name:UIApplicationDidBecomeActiveNotification, object:nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    
    
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        if (messageComposer.canSendText()) {
            
            var place: NamedPlace
            if let target = navigation.places.target {
                place = target
            } else {
                place = NamedPlace(name: "Current place", location: navigation.currentLocation!)
            }
            enum SendMessage: Int {
                case TextMessage
            }
            let message = place.sendMessage(type: SendMessage.TextMessage.rawValue)
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(messageBody: message)
            presentViewController(messageComposeVC, animated: true, completion: nil)

            
        } else {
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    func appDidBecomeActive(notification:  NSNotification) {
    //override func viewWillAppear(animated: Bool) {
        if let url = self.openUrl {
            var components = url.pathComponents
            let place = NamedPlace(name: "Receied place", latitude: components[1].doubleValue, longitude:components[2].doubleValue)
            navigation.setTarget(place: place)
            mapKitView.addAnnotation(navigation.places.target)
            self.openUrl = nil
            
        }
    }
    
    
    
    
}

