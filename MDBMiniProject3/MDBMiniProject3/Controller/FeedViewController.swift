//
//  FeedViewController.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit
import Firebase
class FeedViewController: UIViewController {

    var events : [Event]!
    @IBOutlet weak var tableView: UITableView!
    var selectedEvent : Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        events = []
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
        updateTable()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func signOut(){
        /*let defaults = UserDefaults.standard
        defaults.set("", forKey: "signedInUser")*/
        try! Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    func updateTable(){
        events.removeAll()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }//UserDefaults.standard.string(forKey: "signedInUser")
        let ref = Database.database().reference()
        //let userRef = ref.child("users").child(uid)
        let eventRef = ref.child("events")
        eventRef.observe(DataEventType.value, with: { (snapshot) in
          let eventDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.events.removeAll()
            //print("Event dict: \(eventDict)")
            for id in eventDict.keys {
                ref.child("users").child(eventDict[id]!["creator"]!! as! String).observeSingleEvent(of: .value) { (snapshot) in
                    let user = snapshot.value as? [String : AnyObject] ?? [:]
                    let creator = user["name"]
                    //print(creator!)
                    //let creator = eventDict[id]!["creator"]!!
                    //let date = Date(milliseconds: eventDict[id]!["date"]!!)
                    //let date = Date(timeIntervalSince1970: TimeInterval((int)eventDict[id]!["date"]!!))
                    
                    let date = Date(timeIntervalSince1970: TimeInterval((eventDict[id]!["date"]!! as! Double)))// * 1000))
                    //let timeinterval = TimeInterval((eventDict[id]!["date"]!! as! Double ) * 1000)
                    
                    let description = eventDict[id]!["description"]!!
                    let title = eventDict[id]!["title"]!!
                    var interested = eventDict[id]!["interested"]!
                    if interested == nil {
                        interested = []
                    }
                    else {
                        interested = interested!
                    }
                    
                    let storage = Storage.storage().reference()
                    storage.child("images").child(id).getData(maxSize: 1 * 1024 * 1024){ (data, error) in
                        //print(data)
                        if data == nil {
                            return
                        }
                        guard let image = UIImage(data: data!) else {
                            //print("fail")
                            return
                        }
                       // print("success")
                        
                        self.events.append(Event(title: title as! String, description: description as! String, image: image, date: date, creator: creator as! String, interested: interested as! [String], id: id))
                        //print(self.events)
                        self.events.sort { (a, b) -> Bool in
                            a.date > b.date
                        }
                        print(self.events.count)
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            //print(self.events)
            
        })

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue to detailed view
        print("hello")
        if segue.identifier == "showDetails" {
            /*if let indexPath = tableView.indexPathForSelectedRow {
                let event: Event
                event = events[indexPath.row]*/
                let controller =  segue.destination as! DetailViewController
                controller.detailEvent = selectedEvent
            //}
        }
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
