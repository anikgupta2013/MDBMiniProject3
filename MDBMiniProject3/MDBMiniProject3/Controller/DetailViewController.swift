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
        dateLabel.text = dateFormatterPrint.string(from: detailEvent.date)
    }
    
    func updateEvent(){
        let ref = Database.database().reference()
        let eventRef = ref.child("events")
        eventRef.observe(DataEventType.value, with: { (snapshot) in
            let eventDict = snapshot.value as? [String : AnyObject] ?? [:]
            let event = eventDict[self.detailEvent.id]!
            ref.child("users").child(event["creator"]! as! String).observeSingleEvent(of: .value) { (snapshot) in
                let user = snapshot.value as? [String : AnyObject] ?? [:]
                let creator = user["name"]
                let date = Date(timeIntervalSince1970: TimeInterval((event["date"]! as! Double)))
                let description = event["description"]!
                let title = event["title"]!
                var interest = event["interested"]
                var interested = [] as [String]
                if let a = interest! {
                    interested = a as! [String]
                }
                let storage = Storage.storage().reference()
                storage.child("images").child(self.detailEvent.id).getData(maxSize: 1 * 1024 * 1024){ (data, error) in
                    if data == nil {
                        return
                    }
                    guard let image = UIImage(data: data!) else {
                        return
                    }
                    self.detailEvent = Event(title: title as! String, description: description as! String, image: image, date: date, creator: creator as! String, interested: interested as! [String], id: self.detailEvent.id)
                    self.setData()
                    
                }
                    
            }
                
        })
    }
    @objc func handleStarToggle(sender: UIButton) {
        guard let uid = Auth.auth().currentUser?.uid else {
           return
        }
        let ref = Database.database().reference()
        let interestedRef = ref.child("events").child(detailEvent.id).child("interested")
        interestedRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            var eventDict = snapshot.value as? [String] ?? []
            if eventDict.contains(uid){
                eventDict.remove(at: eventDict.firstIndex(of: uid) ?? 0)
            }
            else {
                eventDict.append(uid)
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
