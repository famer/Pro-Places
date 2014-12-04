//
//  PlacesSet.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 16.10.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation

class PlacesSet: NSObject, NSCoding {
    
    let config = (storedFileName: "stored.data", deletedFileName: "deleted.data", keyForCodedData: "codedData")
    
    var stored: [Place] = [Place]();
    var deleted: [Place] = [Place]();
    
    var target: NamedPlace? = nil {
        didSet {
            if let targetPlace = target {
                if targetPlace.idInArray == nil {
                    addPlace(targetPlace)
                }
                
                //self.saveState()
            }
        }
    }
    override init() {
        super.init()
    }
    
    func toArray() -> NSArray {
        return stored
    }
    
    var numberOfStored: Int {
        return stored.count;
    }
    
    func removeTarget() {
        target = nil
        self.saveState()
    }
    
    func addPlace(place: Place) {
        place.idInArray = numberOfStored
        stored.append(place)
        self.saveState()
    }
    
    func deletePlace(index: Int) {
        let removed = stored.removeAtIndex(index)
        
        for i in removed.idInArray!..<numberOfStored {
            stored[i].idInArray = stored[i].idInArray! - 1
        }
        removed.idInArray = nil
        deleted.append(removed) //insert(removed, atIndex: 0)
        self.saveState()
    }
    
    func deleteFromRemoved(index: Int) {
        deleted.removeAtIndex(index)
        self.saveState()
    }
    
    subscript(i: Int) -> Place {
        get {
            return stored[i];
        }
        set {
            stored[i] = newValue;
            self.saveState()
        }
    }
    
    func update(places : [Place]) {
        updatingLoop: for p in places {
            for storedPlace in stored {
                if p.equal(storedPlace) {
                    continue updatingLoop
                }
            }
            self.addPlace(p)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.target = aDecoder.decodeObjectForKey("target") as? NamedPlace
        self.stored = aDecoder.decodeObjectForKey("stored") as [Place]
        self.deleted = aDecoder.decodeObjectForKey("deleted") as [Place]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
            aCoder.encodeObject(self.target, forKey: "target")
            aCoder.encodeObject(self.stored, forKey: "stored")
            aCoder.encodeObject(self.deleted, forKey: "deleted")
        
    }
    
    func saveState() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: config.keyForCodedData)
    }
    
    func clearState() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(config.keyForCodedData)
        NSUserDefaults.standardUserDefaults().removeObjectForKey("stored")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("deleted")
    }
    
    func loadState()  {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(config.keyForCodedData) as? NSData {
            if let ps = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? PlacesSet {
                self.target = ps.target
                self.stored = ps.stored
                self.deleted = ps.deleted
            }
        }
    }
    /*
    
    func saveState()  {
        let data1 = NSKeyedArchiver.archivedDataWithRootObject(self.stored)
        NSUserDefaults.standardUserDefaults().setObject(data1, forKey: "stored")
        
        let data2 = NSKeyedArchiver.archivedDataWithRootObject(self.deleted)
        NSUserDefaults.standardUserDefaults().setObject(data2, forKey: "deleted")
        
        //return NSKeyedArchiver.archiveRootObject(self.stored, toFile: config.storedFileName) &&
        //NSKeyedArchiver.archiveRootObject(self.deleted, toFile: config.deletedFileName)
    }
    
    func loadState() {
        if let data1 = NSUserDefaults.standardUserDefaults().objectForKey("stored") as? NSData {
            if let s = NSKeyedUnarchiver.unarchiveObjectWithData(data1) as? [NamedPlace] {
                self.stored = s
            }
        }
        if let data2 = NSUserDefaults.standardUserDefaults().objectForKey("deleted") as? NSData {
            if let d = NSKeyedUnarchiver.unarchiveObjectWithData(data2) as? [NamedPlace] {
                self.deleted = d
            }
        }
        /*
        if let storedFromFile = NSKeyedUnarchiver.unarchiveObjectWithFile(config.storedFileName) as? [Place] {
            self.stored = storedFromFile
        }
        if let deletedFromFile = NSKeyedUnarchiver.unarchiveObjectWithFile(config.deletedFileName) as? [Place] {
            self.deleted = deletedFromFile
        }*/
    }*/
    
    
}