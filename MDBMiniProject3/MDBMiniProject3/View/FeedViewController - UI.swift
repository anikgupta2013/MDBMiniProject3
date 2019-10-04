//
//  FeedViewController - UI.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

extension FeedViewController {

    
    func setNavBar(){
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
