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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nameLabel.text = contactsCopy2.
    }
}
