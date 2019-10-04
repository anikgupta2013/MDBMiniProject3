//
//  DetailViewController - UI.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 10/3/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import Foundation
import UIKit

extension DetailViewController{
    func setUI(){
        eventImage.contentMode = .scaleToFill
        eventImage.layer.cornerRadius = 10
        interestedStar.setImage(UIImage(systemName:  "star.fill"), for: .selected)
        interestedStar.addTarget(self, action: #selector(handleStarToggle), for: .touchUpInside)
    }
}
