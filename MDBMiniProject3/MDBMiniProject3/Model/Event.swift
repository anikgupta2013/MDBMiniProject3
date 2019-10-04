//
//  Event.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 10/2/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import Foundation
import UIKit

class Event {
    let title: String!
    let description: String!
    let image: UIImage!
    let date: Date!
    let creator: String!
    let interested: [String]!
    let id: String!
    
    init(title: String, description: String, image: UIImage, date: Date, creator: String, interested: [String], id: String){
        self.title = title
        self.description = description
        self.image = image
        self.date = date
        self.creator = creator
        self.interested = interested
        self.id = id
    }
}
