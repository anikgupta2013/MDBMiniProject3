//
//  FeedViewController - TableFunctions.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO - find the # of events
        print(events.count)
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = indexPath[1]
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        /*for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }*/
        
        cell.awakeFromNib()
        let size = CGSize(width: tableView.frame.width, height: height(for: indexPath))
        cell.initCellFrom(size: size)
        cell.selectionStyle = .none
        print("Row \(indexPath.row)")
        print(events)
        cell.event = events[indexPath.row]
        return cell
        // TODO - set all labels/images of cell
        //cell.imageView?.image = events[index].image//UIImage(contentsOfFile: "mdblogo.png")
        /*cell.eventTitle.text = events[index].title//"Social"
        cell.eventCreator.text = events[index].creator//"John"
        cell.attendeeNumber.text = "\(events[index].interested.count)"//"4"
        return cell*/
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath[1]
        selectedEvent = events[index]
        performSegue(withIdentifier: "showDetails", sender: self)
        
        //TODO - set data and segue to detailed view
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: indexPath)
    }
    
    func height(for index: IndexPath) -> CGFloat {
        return 250
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
