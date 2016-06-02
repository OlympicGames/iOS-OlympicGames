//
//  User.swift
//  OlympicGames
//
//  Created by Macbook on 22/05/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    private var _userRef: Firebase!
    
    private var _userKey: String!
    private var _userName: String!
    private var _userEmail: String
    private var _userProvider: String!
    
    var userKey: String {
        return _userKey
    }
    
    var userName: String {
        return _userName
    }
    
    var userEmail: String {
        return _userEmail
    }
    
    var userProvider: String {
        return _userProvider
    }
    
    
    // Initialize the new User
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = key
        
        // Within the USer, or Key, the following properties are children
        
        if let userName = dictionary[USER_NAME] as? String {
            self._userName = userName
        } else {
            self._userName = ""
        }
        
        if let userEmail = dictionary[USER_EMAIL] as? String {
            self._userEmail = userEmail
        } else {
            self._userEmail = ""
        }
        
        if let userProvider = dictionary[USER_PROVIDER] as? String {
            self._userProvider = userProvider
        } else {
            self._userProvider = ""
        }
        
        // The above properties are assigned to their key.
        
        self._userRef = DataService.dataService.USER_REF.childByAppendingPath(self._userKey)
    }
    
}
