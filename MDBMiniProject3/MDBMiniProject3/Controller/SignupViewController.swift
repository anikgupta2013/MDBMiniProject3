//
//  SignupViewController.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/26/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit
import Firebase
class SignupViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("hello")
        setUI()
        setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignupPressed(_ sender: Any) {
        
        var name = ""
        var username = ""
        var email = ""
        var password = ""
        /* PART 1B START*/
        name = nameField.text!
        if name == "" {
            self.displayAlert(title: "Missing name", message: "Please include your name.")
            return
        }
        username = usernameField.text!
        if username == "" {
            self.displayAlert(title: "Missing username", message: "Please include your username.")
            return
        }
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
        
        /* PART 1B FINISH*/
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                //self.loginRegisterButton
                //print(error)
                self.displayAlert(title: "There was an error", message: error.localizedDescription)
                return
            } else {
                
                guard let uid = user?.user.uid else {
                    return
                }
                let ref = Database.database().reference()
                let userRef = ref.child("users").child(uid)
                let values = ["name": name, "username": username, "email": email]
                
                userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        //print(error)
                        self.displayAlert(title: "There was an error", message: "Couldn't create your profile")
                        return
                    } else {
                        /*let defaults = UserDefaults.standard
                        defaults.set(uid, forKey: "signedInUser")*/
                        //self.ourUserID = user?.uid
                        self.performSegue(withIdentifier: "toFeedView", sender: self)
                    }
                })
            }
        })
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func cancel(){
        navigationController?.popViewController(animated: true)
    }
}
