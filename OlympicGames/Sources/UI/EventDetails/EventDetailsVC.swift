//
//  EventDetailsVC.swift
//  OlympicGames
//
//  Created by Macbook on 23/04/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class EventDetailsVC: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var goButton: UILabel!
    
    //MARK: Variable
    var event: Event?
    //var facebook: Facebook!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        goButton.text = event?.artistName
        
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            //goButton.textColor = UIColor.greenColor()
            self.facebookLogin(sender)
        } else {
            goButton.textColor = UIColor.redColor()
        }
    }
    
}
