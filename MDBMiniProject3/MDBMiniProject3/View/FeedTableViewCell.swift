//
//  FeedTableViewCell.swift
//  MDBMiniProject3
//
//  Created by Anik Gupta on 9/30/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var event: Event? {
        didSet {
            if let event = event {
                eventCreator.text = "Created by: " + event.creator
                attendeeNumber.text = "\(event.interested.count)"
                eventTitle.text = event.title
                eventImage.image = event.image
            }
        }
    }
    
    var eventImage: UIImageView!
    var eventTitle: UILabel!
    var eventCreator: UILabel!
    var attendeeNumber: UILabel!
    var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        /*eventImage = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        
        eventImage.layer.cornerRadius = 7
        eventImage.center = CGPoint(x: contentView.frame.width/2, y: contentView.frame.height/2)*/
        /*eventImage = UIImageView(frame: CGRect(x: 0, y: 10, width: contentView.frame.width, height: contentView.frame.height-30))
        //eventImage.image = UIImage(named: "event1")
        eventImage.contentMode = .scaleToFill
        eventImage.layer.cornerRadius = 22
        eventImage.layer.masksToBounds = true
        eventImage.alpha = 1.0*/
        //contentView.addSubview(eventImage)
        
        
        /*eventTitle = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 40))
        eventTitle.textColor = UIColor.black
        
        eventCreator = UILabel(frame: CGRect(x: 0, y: 100, width: contentView.frame.width - 40, height: 40))
        eventCreator.textColor = UIColor.black
        
        attendeeNumber = UILabel(frame: CGRect(x: 0, y: 100, width: contentView.frame.width, height: 40))
        
        attendeeNumber.textColor = UIColor.white
        attendeeNumber.textAlignment = .right
        
        
        
        contentView.addSubview(eventTitle)
        contentView.addSubview(eventCreator)
        contentView.addSubview(attendeeNumber)
        //contentView.addSubview(eventImage)*/

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCellFrom(size: CGSize) {
        
        eventImage = UIImageView(frame: CGRect(x: 0, y: 10, width: size.width, height: size.height-30))
        //eventImage.image = UIImage(named: "event1")
        eventImage.contentMode = .scaleToFill
        eventImage.layer.cornerRadius = 10
        eventImage.layer.masksToBounds = true
        eventImage.alpha = 1.0
        contentView.addSubview(eventImage)

        
        let imageTint = UIView()
        imageTint.backgroundColor = UIColor(white: 0, alpha: 0.4)
        imageTint.frame = eventImage.frame
        imageTint.layer.cornerRadius = 10
        
        contentView.addSubview(imageTint)
        
        eventTitle = UILabel(frame: CGRect(x: 20, y: size.height-70, width: size.width-20, height: 40))
        eventTitle.numberOfLines = 0
        eventTitle.adjustsFontSizeToFitWidth = true
        eventTitle.minimumScaleFactor = 0.3
        eventTitle.font = UIFont(name: "Helvetica-Bold", size: 35)
        eventTitle.textColor = .white
        eventTitle.textAlignment = .left
        contentView.addSubview(eventTitle)
        
        eventCreator = UILabel(frame: CGRect(x: 20, y: eventTitle.frame.maxY-70, width: size.width-20, height: 30))
        eventCreator.text = "ASUC Superb"
        eventCreator.numberOfLines = 1
        eventCreator.adjustsFontSizeToFitWidth = true
        eventCreator.minimumScaleFactor = 0.3
        eventCreator.font = UIFont(name: "Helvetica-SemiBold", size: 25)
        eventCreator.textColor = .white
        eventCreator.textAlignment = .left
        contentView.addSubview(eventCreator)
        
        icon = UIImageView(frame: CGRect(x: size.width-45, y: 22, width: 30, height: 30))
        icon.contentMode = .scaleAspectFit
        //icon.image = UIImage(named: "person")
        icon.image = UIImage(systemName: "person")
        icon.tintColor = .white
        contentView.addSubview(icon)
        
        attendeeNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        attendeeNumber.center = CGPoint(x: icon.frame.midX, y: icon.frame.maxY + 20)
        
        attendeeNumber.adjustsFontSizeToFitWidth = true
        attendeeNumber.minimumScaleFactor = 0.3
        attendeeNumber.font = UIFont(name: "Helvetica-Medium", size: 26)
        attendeeNumber.textColor = .white
        attendeeNumber.textAlignment = .center
        contentView.addSubview(attendeeNumber)
        
        
    }

}
