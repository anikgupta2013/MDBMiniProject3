//
//  SignupViewController - UI.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

extension SignupViewController{
    func setUI(){
        signUp.layer.cornerRadius = 7
    }
    func setNavigationBar(){
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
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
