//
//  AddEventViewController.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController {

    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImagePressed(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func createEventPressed(_ sender: Any) {
        var description = descriptionField.text
        /* PART 1B START*/
        //var date = (Int) (dateSelector.date.timeIntervalSince1970)
        var date = dateSelector.date.timeIntervalSince1970.magnitude
        var title = nameField.text
        if title == "" {
            self.displayAlert(title: "Error", message: "Please enter a title")
            return
        }
        guard var image = imageButton.currentImage?.jpegData(compressionQuality: 0.4) else {
            self.displayAlert(title: "Error", message: "Please select an image")
            return
        }
        if description == "" {
            self.displayAlert(title: "Error", message: "Please enter a description")
            return
        }

        //TODO - enter data into database
        guard let uid = Auth.auth().currentUser?.uid else {
            self.displayAlert(title: "There was an error", message: "Couldn't create your event")
            return
        }//UserDefaults.standard.string(forKey: "signedInUser")
        //print(uid)
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid)
        let eventRef = ref.child("events").childByAutoId()
        let key = eventRef.key
        let post = ["creator": uid,
                    "description": description,
                    "date": date,
                    "title": title,
                    /*"image": image,*/
                    "interested": []] as [String : Any]
        //let userEventsRef = userRef.child("created_events")
        let a = userRef.child("created_events")//.child(key!)
        let childUpdates = ["/events/\(key!)" : post]
        
        
        a.observeSingleEvent(of: .value){ (snapshot) in
            var events = snapshot.value as? [String]
            
            let storage = Storage.storage().reference()
            storage.child("images").child(key!).putData(image, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.displayAlert(title: "There was an error", message: "Couldn't associate your image")
                }
                
                if events == nil {
                    events = [key!]
                }
                else {
                    events?.append(key!)
                }
                a.setValue(events!)
                ref.updateChildValues(childUpdates)
            }
            
            
            
        }
       //a.updateChildValues(post)
        
        
        
        dismiss(animated: true)
        //let values = ["name": name, "username": username, "email": email]
        /*userRef.observeSingleEvent(of: .value) { (snapshot) in
            let userInfo = snapshot.value as? [String: AnyObject]
            var eventList : [String]!
            if userInfo?.keys.contains("events") ?? false{
                eventList = userInfo?["events"]
                eventList.append(/*insert eventID*/)
            }
            else {
                eventList = [/*insert eventID*/]
            }
            let values = ["events": eventList]
            let userEventsRef = userRef.child("events")
            let eventRef = userEventsRef.child(/*insert eventID*/)
            userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error)
                    self.displayAlert(title: "There was an error", message: "Couldn't create your event")
                    return
                } else {
                    dismiss(animated: true)
                }
            })
            
        }*/
        
        
        
        
        
        
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
}
extension AddEventViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageButton.setImage(image, for: UIControl.State.normal)
    }
}
