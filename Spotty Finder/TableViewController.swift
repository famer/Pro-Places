//
//  TableViewController.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 17.11.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let navigation: Navigation = Navigation.sharedInstance
    let sectionTitles = ["Removed", "Signal festival"]
    let providedSectionItems = ["Library", "Opera", "Underwater", "Big clock", "Charles bridge"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // in case self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
        if (self.tableView(self.tableView, numberOfRowsInSection: 0) == 0) {
            let iView = UIView(frame:CGRectMake(0.0, 0.0, 100.0, 30.0))
            let iTitleLabel = UILabel(frame: CGRect(x: 50.0, y: 0.0, width: 100.0, height: 45.0))
            iTitleLabel.textColor = UIColor.darkTextColor()
            iTitleLabel.text = "No items"
            iTitleLabel.adjustsFontSizeToFitWidth = true
            iView.addSubview(iTitleLabel)
            self.tableView.tableFooterView = iView
        } else {
            self.tableView.tableFooterView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return navigation.places.deleted.count
        case 1:
            return providedSectionItems.count
        default:
            return navigation.places.deleted.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Place Cell", forIndexPath: indexPath) as UITableViewCell
        //println(indexPath)
        if ( indexPath.section == 0 ) {
            let place = navigation.places.deleted[indexPath.row] as NamedPlace
            cell.imageView.image = place.image
            cell.textLabel.text = place.title
            cell.detailTextLabel?.text = place.subtitle
        } else if ( indexPath.section == 1 ) {
            cell.textLabel.text = providedSectionItems[indexPath.row]
        }

        return cell
    }
    
    // header in a section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        self.revealViewController().revealToggleAnimated(true)
        
        // temporary stuff for not flashing storage
        //navigation.places.deleted[indexPath.row].idInArray = nil
        
        
        navigation.setTarget(place: (navigation.places.deleted[indexPath.row] as NamedPlace))
        navigation.places.deleteFromRemoved(indexPath.row)
        
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Right)
        
        (self.revealViewController().frontViewController as ViewController).mapKitView.addAnnotation(navigation.places.target)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
       navigation.places.deleteFromRemoved(indexPath.row)
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Fade)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        println("segue")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    

}
