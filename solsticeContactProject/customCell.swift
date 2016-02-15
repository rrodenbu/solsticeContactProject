//
//  customCell.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/15/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import UIKit
import MapKit

class customCell: UITableViewCell {
    
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var contactName: UILabel!

    func configureCellWith(contactInfo: Contact) {
        //set image not based online
        contactName.text = contactInfo.name
        print(contactInfo.smallImageURL)
        print(contactInfo.name)
        //Loading photos from online
        if let url = NSURL(string: contactInfo.smallImageURL) {
            if let data = NSData(contentsOfURL: url){
                contactImage.image = UIImage(data: data)
            }
        }
    }
    
}
