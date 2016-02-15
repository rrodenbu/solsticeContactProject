//
//  tableViewController.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/14/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import UIKit

class tableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    //SEGUE: From SplashScreenViewController
    var contactsCopy = [Contact]()
    var doneRetrievingData = false;
    
    //To order alphabetically:
    var letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Loaded")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    /**********************************START CONSTRUCTING TABLE******************************/
     //BEGIN CELL ANIMAITON
    

     
    //CONFIGURING TABLE WITH CELLS
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("CREATING SECTIONS");
        return 1;
    }
    
    //HEADER TITLES FOR SECTIONS: not implemented yet
    /*func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(All == true) {
            if(section == 0) {
                return "A"
            } else if (section == 1) {
                return "B"
            } else {
                return "..."
            }
        }
        return nil
    }*/
    
    //NUMBER OF CELLS IN THAT SECTION
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CREATING NUMBER OF CELLS")
        return contactsCopy.count;
    }

    //index path which section which row, creating cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("CREATING CELL");
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell ID", forIndexPath: indexPath) as! customCell
        var currContact = self.contactsCopy[indexPath.row]
        cell.configureCellWith(currContact)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailSegue") {
            var nextScene =  segue.destinationViewController as! detailViewController
            nextScene.index = self.tableView.indexPathForCell(sender as! UITableViewCell)!.row
            nextScene.contactsCopy2 = contactsCopy;
        }
    }

    
}