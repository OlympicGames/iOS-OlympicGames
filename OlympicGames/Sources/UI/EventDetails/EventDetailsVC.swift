//
//  EventDetailsVC.swift
//  OlympicGames
//
//  Created by Macbook on 23/04/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation
import UIKit

class EventDetailsVC: UIViewController {
    
    @IBOutlet weak var goButton: UILabel!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        goButton.text = event?.artistName
        
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            goButton.textColor = UIColor.greenColor()
        } else {
            goButton.textColor = UIColor.redColor()
        }
    }
}
