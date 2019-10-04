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
        /*interestedStar.imageRect(forContentRect: CGRect(x: 0, y: 0, width: 100, height: 100))
        interestedStar.wid*/
        
        /*interestedStar.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)*/
       print("a")
       eventImage.contentMode = .scaleToFill
    
        
        /*interestedStar.contentMode = .scaleToFill
        interestedStar.imageView?.contentMode = .scaleAspectFill*/
        /*interestedStar.imageView?.contentMode = .scaleAspectFit*/
        interestedStar.setImage(UIImage(systemName:  "star.fill"), for: .selected)
        interestedStar.addTarget(self, action: #selector(handleStarToggle), for: .touchUpInside)
        eventImage.layer.cornerRadius = 10
    }
}
