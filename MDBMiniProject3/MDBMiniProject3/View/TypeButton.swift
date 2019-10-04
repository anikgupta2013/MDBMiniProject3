//
//  TypeButton.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 10/3/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import Foundation
import UIKit

class TypeButton: UIButton {
    
    //Making a toggle button
    override func draw(_ rect: CGRect) {
        //self.setTitleColor(.white, for: .selected)
        self.contentMode = .scaleToFill
        self.imageView?.contentMode = .scaleAspectFill
        /*interestedStar.imageView?.contentMode = .scaleAspectFit*/
        //self.setImage(UIImage(systemName:  "star.fill"), for: .selected)
        self.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
    }
    @objc func handleToggleBT(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    

}
