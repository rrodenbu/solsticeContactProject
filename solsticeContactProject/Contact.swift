//
//  Contact.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/14/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import Foundation
import UIKit

// Represents a generic retail outlet. Need an image named "default"

class Contact
{
    var name: String
    var employeeID: String
    var company: String
    var detailsURL: String
    var smallImageURL: String
    var birthdate: String
    var workPhone: String
    var homePhone: String
    var cellPhone: String
    
    
    var store: Bool
    var app: Bool
    var image: String//UIImage
    
    init(name: String, store: Bool, app: Bool, imageName: String)
    {
        self.name = name
        self.store = store
        self.app = app
        
        if(imageName != "") {
            image = imageName
        }
        else {
            image = "default"
        }
        
        /*
        if let img = UIImage(named: imageName) {
        image = img
        } else {
        image = UIImage(named: "default")!
        }*/
    }
}