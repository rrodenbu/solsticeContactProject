//
//  Details.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/15/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import Foundation
import UIKit

/* Represents a generic contact. Need an image named "default" */

class Details
{
    var largeImageURL: String
    var email: String
    var website: String
    var address: String
    
    //Set default values.
    init(largeImageURL: String, email: String, website: String, address: String)
    {
        self.largeImageURL = largeImageURL
        self.email = email
        self.website = website
        self.address = address
    }
    
}