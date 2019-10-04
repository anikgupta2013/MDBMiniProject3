//
//  SigninViewController.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/25/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        guard Auth.auth().currentUser != nil else {
            return
        }
        self.performSegue(withIdentifier: "toFeedViewIn", sender: self)
    }

    

    @IBAction func onSigninPressed(_ sender: Any) {
        var email = ""
        var password = ""
        email = emailField.text!
        if email == "" {
            self.displayAlert(title: "Missing email", message: "Please include a valid email.")
            return
        }
        password = passwordField.text!
        if password == "" {
            self.displayAlert(title: "Missing password", message: "Please include your password.")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                self.displayAlert(title: "There was an error", message: "Could not sign in")
                return
            } else {
                self.performSegue(withIdentifier: "toFeedViewIn", sender: self)
            }
            guard let uid = user?.user.uid else {
                return
            }
        })
    }
    @IBAction func onSignUpPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

}

