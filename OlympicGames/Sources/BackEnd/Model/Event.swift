//
//  Event.swift
//  OlympicGames
//
//  Created by Serigne BA on 22/04/2016.
//  Copyright © 2016 Kode. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    private var _eventRef: Firebase!
    
    private var _eventKey: String!
    private var _artistProfilePicture: String!
    private var _artistName: String
    private var _eventPlace: String!
    private var _eventType: String!
    private var _eventPrice: Int!
    
    var eventKey: String {
        return _eventKey
    }
    
    var artistProfilePicture: String {
        return _artistProfilePicture
    }
    
    var artistName: String {
        return _artistName
    }
    
    var eventPlace: String {
        return _eventPlace
    }
    
    var eventType: String {
        return _eventType
    }
    
    var eventPrice: Int {
        return _eventPrice
    }
    
    // Initialize the new Event
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._eventKey = key
        
        // Within the Event, or Key, the following properties are children
        
        if let artistProfilePicture = dictionary[ARTIST_PROFILE_PICTURE] as? String {
            self._artistProfilePicture = artistProfilePicture
        } else {
            self._artistProfilePicture = ""
        }
        
        if let artistName = dictionary[ARTIST_NAME] as? String {
            self._artistName = artistName
        } else {
            self._artistName = ""
        }
        
        if let eventPlace = dictionary[EVENT_PLACE] as? String {
            self._eventPlace = eventPlace
        } else {
            self._eventPlace = ""
        }
        
        if let eventType = dictionary[EVENT_TYPE] as? String {
            self._eventType = eventType
        } else {
            self._eventType = ""
        }
        
        if let eventPrice = dictionary[EVENT_PRICE] as? Int {
            self._eventPrice = eventPrice
        } else {
            self._eventPrice = 0
        }
        // The above properties are assigned to their key.
        
        self._eventRef = DataService.dataService.EVENT_REF.childByAppendingPath(self._eventKey)
    }
    
}