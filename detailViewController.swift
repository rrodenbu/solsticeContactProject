//
//  detailViewController.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/15/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var homePhoneLabel: UILabel!
    @IBOutlet var mobilePhoneLabel: UILabel!
    @IBOutlet var workPhoneLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    
    var contactsCopy2 = [Contact]();
    var index = 0;
    lazy var data = NSMutableData() //JSON
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var currContact = contactsCopy2[index]
        startConnection(currContact)
        
        nameLabel.text = currContact.name
        homePhoneLabel.text = currContact.homePhone
        mobilePhoneLabel.text = currContact.cellPhone
        workPhoneLabel.text = currContact.workPhone
        birthdayLabel.text = currContact.birthdate
    }
    
    //Connect to JSON URL
    func startConnection(currContact: Contact){
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
        let urlPath: String = currContact.detailsURL
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
        let dataDict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(dataDict)
        var address = dataDict["address"]
        var street = address!["street"] as! String
        var city = address!["city"] as! String
        var state = address!["state"] as! String
        var zip = address!["zip"] as! String
        var country = address!["country"] as! String
        var addressPt1 = street + ", " + city + ", "
        var addressPt2 = state + " " + zip + " " + country
        addressLabel.text = addressPt1 + addressPt2
        emailLabel.text = dataDict["email"] as! String
        websiteLabel.text = dataDict["website"] as! String
        var largeImageURL = dataDict["largeImageURL"] as! String
        if let url = NSURL(string: largeImageURL) {
            if let data = NSData(contentsOfURL: url){
                profileImage.image = UIImage(data: data)
            }
        }
        
        

        
        print("COMPLETED RETRIEVING JSON DATA")
    }
}
