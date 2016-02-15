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

class loadingScreenController: UIViewController {
    var retailArray = [Store]()
    var storeArray = [Store]()
    var bankArray = [Store]()
    var appArray = [Store]()
    lazy var data = NSMutableData() //JSON
    
    @IBOutlet var loader: UIImageView!
    @IBOutlet var warningLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startConnection() //Start retrieving information from JSON file.
        
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
        loader.startAnimating()
    }
    
    //JSON STUFF START:
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
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        
        if let allStores = jsonResult["results"] as? NSDictionary {
            
            //RETAILERS
            if let storesArray = allStores["collection1"] as? NSArray {
                
                print("RETRIEVING RETAILERS...")
                
                let totalNumberOfStores = storesArray.count
                
                for index in 0...(totalNumberOfStores - 1) {
                    
                    let storesProperties = storesArray[index] as! NSDictionary
                    let storeNames = storesProperties["property2"] as! NSDictionary
                    //print(storeNames);
                    let name = storesProperties["property1"] as! String
                    let URL = storeNames["src"] as! String
                    
                    retailArray.append(Store(name: name, store: true, app: false, imageName: URL))
                    storeArray.append(Store(name: name, store: true, app: false, imageName: URL))
                    
                }
            }
            
            //BANKS
            if let storesArray = allStores["collection2"] as? NSArray {
                
                print("RETRIEVING Banks...")
                
                let totalNumberOfStores = storesArray.count
                
                for index in 0...(totalNumberOfStores - 1) {
                    
                    let storeNames = storesArray[index] as! NSDictionary
                    let name = storeNames["property3"] as! String
                    retailArray.append(Store(name: name, store: true, app: false, imageName: ""))
                    bankArray.append(Store(name: name, store: true, app: false, imageName: ""))
                    
                }
            }
            
            //APPS
            if let storesArray = allStores["collection3"] as? NSArray {
                
                print("RETRIEVING Apps...")
                
                let totalNumberOfStores = storesArray.count
                
                for index in 0...(totalNumberOfStores - 1) {
                    
                    let storeNames = storesArray[index] as! NSDictionary
                    let name = storeNames["property4"] as! String
                    retailArray.append(Store(name: name, store: true, app: false, imageName: ""))
                    appArray.append(Store(name: name, store: true, app: false, imageName: ""))
                    
                }
            }
            
            //print(retailArray.count)
            print("COMPLETED RETRIEVING THE DATA")
            
            
            self.performSegueWithIdentifier("customSegue", sender: self)
        }
        
    }
    
    //JSON STUFF END.
    
    //SEGUE STUFF START:
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! UINavigationController
        let finalDestVC = destinationVC.topViewController as! ViewController
        finalDestVC.retailArrayCopy = retailArray
        finalDestVC.storeArrayCopy = storeArray
        finalDestVC.banksArrayCopy = bankArray
        finalDestVC.appsArrayCopy = appArray
        finalDestVC.totalItems = retailArray.count
        
        
    }
    
    //SEGUE STUFF END.
    
}

