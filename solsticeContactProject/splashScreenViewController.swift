//
//  splashScreenViewController.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/14/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

//
//  loadingScreen.swift
//  ApplePayWhere
//
//  Created by Riley Rodenburg on 9/2/15.
//  Copyright © 2015 Riley Rodenburg. All rights reserved.
//

import UIKit
import Foundation

class splashScreenViewController: UIViewController {
    var contacts = [Contact]()
    lazy var data = NSMutableData() //JSON
    
    @IBOutlet var loader: UIImageView!
    @IBOutlet var warningLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startConnection() //Start retrieving information from JSON file.
       /*
        loader.animationImages = [UIImage]()
        warningLabel.animationImages = [UIImage]()
        warningLabel.hidden = true
        
        for var index = 0; index < 200; index++ {
            //print(index)
            let frameName = String(format: "loadImage%05d", index)
            //print(frameName)
            loader.animationImages?.append(UIImage(named: frameName)!)
        }
        
        for var index2 = 0; index2 < 74; index2++ {
            //print(index2)
            let frameName = String(format: "noInternet_%05d", index2)
            warningLabel.animationImages?.append(UIImage(named: frameName)!)
        }
        
        loader.animationDuration = 5
        loader.startAnimating()*/
    }
    
    //Connect to JSON URL
    func startConnection(){
        print("CONNECTING TO WEBSITE...")
        
        //CEHCKING FOR INTERNET ACESS
        if Reachability.isConnectedToNetwork() == true { //Internet
            print("Internet connection OK.")
        } else { //No internet.
            print("Internet connection FAILED")
            
            //Set-up pop-up message.
            let alertController = UIAlertController(title: "No Internet Connection.", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            //Set-up dismiss alert button.
            let destroyAction = UIAlertAction(title: "Destroy", style: .Destructive) { (action) in
                print(action)
            }
            alertController.addAction(destroyAction)
            
            //Show pop-up
            self.presentViewController(alertController, animated: true) {
            }
        }
        
        //GETTING JSON FILE.
        let urlPath: String = "https://solstice.applauncher.com/external/contacts.json"
        let url: NSURL = NSURL(string: urlPath)!
        print("REQUESTING WEBSITE CONNECTION.")
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        print("CONNECTED.")
        self.data.appendData(data)
    }
    
    //PARSE JSON FILE.
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        print("READING JSON FILE AND PARSING...")
        
        //Download JSON into array.
        let dataDict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        
        //Loop through array and save contact info in contacts array.
        for index in 1..<dataDict.count {
            
            let name = dataDict[index]["name"] as! String
            let employeeID = dataDict[index]["employeeId"] as! Int
            let company = dataDict[index]["company"] as! String
            let detailsURL = dataDict[index]["detailsURL"] as! String
            let smallImageURL = dataDict[index]["smallImageURL"] as! String
            let birthdate = dataDict[index]["birthdate"] as! String
            
            let phone = dataDict[index]["phone"] as! NSDictionary
            
            let workPhone = phone["work"] as! String
            let homePhone = phone["home"] as! String
            var cellPhone = ""
            if(phone["mobile"] != nil) { //Someone doesn't have a cell phone...
               cellPhone = phone["mobile"] as! String
            }
            
            contacts.append(Contact(name: name, employeeID: employeeID, company: company, detailsURL: detailsURL, smallImageURL: smallImageURL, birthdate: birthdate, workPhone: workPhone, homePhone: homePhone, cellPhone: cellPhone))
        }

        print("COMPLETED RETRIEVING JSON DATA")
        self.performSegueWithIdentifier("tableSegue", sender: self)
    }
    
    //SEGUE STUFF START:
    //Transfering data between screens.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "tableSegue") {
            let DestViewController = segue.destinationViewController as! UINavigationController
            let targetController = DestViewController.topViewController as! tableViewController
            targetController.contactsCopy = contacts
        }
    }
    
}

