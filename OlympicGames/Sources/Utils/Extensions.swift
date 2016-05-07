//
//  Extensions.swift
//  OlympicGames
//
//  Created by Macbook on 01/05/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation

// MARK: EventsFeedVC

// MARK: NSUserDefaults

extension NSUserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = NSUserDefaults.standardUserDefaults().stringForKey(firstLaunchFlag) == nil
        if (isFirstLaunch) {
            NSUserDefaults.standardUserDefaults().setObject("false", forKey: firstLaunchFlag)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return isFirstLaunch
    }
}
