//
//  DetailViewController.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 10/3/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    var detailEvent : Event!
    @IBOutlet weak var interestedStar: UIButton!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var interestedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        updateEvent()
        setData()
        // Do any additional setup after loading the view.
    }
    
    func setData(){
        guard let uid = Auth.auth().currentUser?.uid else {
           return
        }
        eventName.text = detailEvent.title
        eventImage.image = detailEvent.image
        creatorLabel.text = "Creator: \(detailEvent.creator!)"
        interestedLabel.text = "Interested People: \(detailEvent.interested.count)"
        descriptionLabel.text = detailEvent.description
        interestedStar.isSelected = detailEvent.interested.contains(uid)
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEE, MMM d, yyyy h:mm a"

        /*if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26") {
            print(dateFormatterPrint.string(from: date))
        } else {
           print("There was an error decoding the string")
        }*/
        print(detailEvent.date)
        dateLabel.text = dateFormatterPrint.string(from: detailEvent.date)
    }
    
    func updateEvent(){
        /*guard let uid = Auth.auth().currentUser?.uid else {
           return
        }*/
        let ref = Database.database().reference()
        let eventRef = ref.child("events")//.child(detailEvent.id)
        eventRef.observe(DataEventType.value, with: { (snapshot) in
            let eventDict = snapshot.value as? [String : AnyObject] ?? [:]
            //print("Event dict: \(eventDict[self.detailEvent.id])")
            let event = eventDict[self.detailEvent.id]!
            ref.child("users").child(event["creator"]! as! String).observeSingleEvent(of: .value) { (snapshot) in
                    let user = snapshot.value as? [String : AnyObject] ?? [:]
                    //print(user)
                    let creator = user["name"]
                    //print(creator!)
                    //let creator = eventDict[id]!["creator"]!!
                    //let date = Date(milliseconds: eventDict[id]!["date"]!!)
                    //let date = Date(timeIntervalSince1970: TimeInterval((int)eventDict[id]!["date"]!!))
                print(event["date"]!)
                    let date = Date(timeIntervalSince1970: TimeInterval((event["date"]! as! Double)))// * 1000))
                    //let timeinterval = TimeInterval((eventDict[id]!["date"]!! as! Double ) * 1000)
                    
                    let description = event["description"]!
                    let title = event["title"]!
                    var interest = event["interested"]
                    var interested = [] as [String]
                if let a = interest! {
                    interested = a as! [String]
                        /*print("isnil")
                        interested = [""] as! [String]*/
                    }
                    /*else {
                        let interested = [] as! [String]
                    }*/
                    
                    let storage = Storage.storage().reference()
                storage.child("images").child(self.detailEvent.id).getData(maxSize: 1 * 1024 * 1024){ (data, error) in
                        //print(data)
                        if data == nil {
                            return
                        }
                        guard let image = UIImage(data: data!) else {
                            //print("fail")
                            return
                        }
                        //print("success")
                        
                    self.detailEvent = Event(title: title as! String, description: description as! String, image: image, date: date, creator: creator as! String, interested: interested as! [String], id: self.detailEvent.id)
                        //print(self.events)
                        /*self.events.sort { (a, b) -> Bool in
                            a.date > b.date
                        }
                        self.tableView.reloadData()*/
                        self.setData()
                        
                    }
                    
                }
                
        })
            
        //})
       /*if detailEvent.interested.contains(uid) {
           //interestedStar.im
       }*/
    }
    @objc func handleStarToggle(sender: UIButton) {
        print("toggle")
        guard let uid = Auth.auth().currentUser?.uid else {
           return
        }
        let ref = Database.database().reference()
        let interestedRef = ref.child("events").child(detailEvent.id).child("interested")
        interestedRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            var eventDict = snapshot.value as? [String] ?? []
            if eventDict.contains(uid){
                //while eventDict.contains(uid){
                print("removing")
                    eventDict.remove(at: eventDict.firstIndex(of: uid) ?? 0)
                //}
                // remove from database
            }
            else {
                print("adding")
                eventDict.append(uid)
                //add to database
            }
            
            interestedRef.setValue(eventDict)
            
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

}
