//
//  EventsFeedVC.swift
//  OlympicGames
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class EventsFeedVC: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noSearchResult: UILabel!
    
    //MARK: Variable
    
    var events = [Event]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredEvents = [Event]()
    var showSearchBar: Bool = false
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(EventsFeedVC.searchBar(_:)))
        let rightFbBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "login"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(facebookLogin))
        self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem, rightFbBarButtonItem], animated: true)
        
        addSlideMenuButton()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchController.searchBar.delegate = self
        
        launchRequests()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showPopUp()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //To enabled the search button - compulsory
        enableRightBarButtonItems()
    }
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         noSearchResult.hidden = true
        if searchController.active && searchController.searchBar.text != "" {
            if filteredEvents.count == 0 {
                print("no result found")
                noSearchResult.hidden = false
            }
            return filteredEvents.count
        }
        return events.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let event: Event
        
        if searchController.active && searchController.searchBar.text != "" {
            event = filteredEvents[indexPath.row]
        } else {
            event = events[indexPath.row]
        }
        
        // We are using a custom cell.
        if let cell = tableView.dequeueReusableCellWithIdentifier("EventCellTableViewCell") as? EventCellTableViewCell {
            cell.configureCell(event)
            return cell
        } else {
            return EventCellTableViewCell()
        }
        
    }
    
    //MARK: IBActions
    
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showEventDetailsSegue":
                let eventDetailsVC = segue.destinationViewController as! EventDetailsVC
                if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                    eventDetailsVC.event = eventAtIndexPath(indexPath)
                }
            default: break
            }
        }
    }
    
    //MARK: Helper method
    
    private func launchRequests() {
        // observeEventType is called whenever anything changes in the Firebase - new Events or Votes.
        // It's also called in viewDidLoad().
        // It's always listening.è
        
        DataService.dataService.EVENT_REF.observeEventType(.Value, withBlock: { snapshot in
            self.activityIndicator.startAnimating()
            
            // The snapshot is a current look at our Events data.
            
            print(snapshot.value)
            
            self.events = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our events array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let event = Event(key: key, dictionary: postDictionary)
                        print("postDictionary \(postDictionary)")
                        // Items are returned chronologically, but it's more fun with the newest events first.
                        
                        self.events.insert(event, atIndex: 0)
                    }
                }
                
            }
            
            self.activityIndicator.stopAnimating()
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
            }, withCancelBlock: { error in
                print(error.description)
                
        })

    }
    
    private func rightBarButtons() {
        let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(EventsFeedVC.searchBar(_:)))
        //let loginBtnItem = UIBarButtonItem(customView:)
        self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem], animated: true)
    }
    
    private func eventAtIndexPath(indexPath: NSIndexPath) -> Event {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredEvents[indexPath.row]
        } else {
            return events[indexPath.row]
        }
    }
    
    private func showPopUp() {
        if NSUserDefaults.isFirstLaunch() {
            let alertView = SCLAlertView()
            alertView.showInfo("Bienvenue :) !", subTitle: "Merci d'avoir télécharger SenEvent ! ")
        }
    }

    private func filterContentForSearchText(searchText: String) {
        filteredEvents = events.filter { event in
            return event.artistName.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    @objc private func searchBar(sender:UIButton) {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        if !showSearchBar {
            searchController.searchBar.hidden = false
            showSearchBar = false
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchBar.becomeFirstResponder()
        } else {
            searchController.searchBar.hidden = true
            showSearchBar = true
            tableView.tableHeaderView = nil
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchController.searchBar.hidden = true
        tableView.tableHeaderView = nil
        showSearchBar = false
    }
    

}

// MARK: Extensions
extension EventsFeedVC: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
