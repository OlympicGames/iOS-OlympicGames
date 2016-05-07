//
//  EventCellTableViewCell.swift
//  OlympicGames
//
//  Created by Serigne BA on 22/04/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

class EventCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistProfilePicture: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var eventPlace: UILabel!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventPrice: UILabel!
    
    var event: Event!
    
    func configureCell(event: Event) {
        self.event = event
        
        // Set the labels and textView.
        self.artistProfilePicture.image = UIImage(named: "defaultPP")
        self.artistProfilePicture.downloadImageFrom(link: event.artistProfilePicture, contentMode:UIViewContentMode.ScaleAspectFit)
        self.artistName.text = event.artistName
        self.eventPlace.text = event.eventPlace
        self.eventType.text = event.eventType
        self.eventPrice.text = "\(event.eventPrice) $$"
    }

}
