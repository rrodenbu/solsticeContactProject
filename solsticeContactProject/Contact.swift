//
//  Contact.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/14/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import Foundation
import UIKit

/* Represents a generic contact. Need an image named "default" */

class Contact
{
    var name: String
    var employeeID: Int
    var company: String
    var detailsURL: String
    var smallImageURL: String
    var birthdate: String
    var workPhone: String
    var homePhone: String
    var cellPhone: String
    
    //Set default values.
    init(name: String, employeeID: Int, company: String, detailsURL: String, smallImageURL: String, birthdate: String, workPhone: String, homePhone: String, cellPhone: String)
    {
        self.name = name
        self.employeeID = employeeID
        self.company = company
        self.detailsURL = detailsURL
        self.birthdate = birthdate
        self.workPhone = workPhone
        self.homePhone = homePhone
        self.cellPhone = cellPhone
        
        if(smallImageURL != "") {
            self.smallImageURL = smallImageURL
        }
        else {
            self.smallImageURL = "default"
        }
    }
    
}