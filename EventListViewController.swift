//
//  EventListViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
    // outlet - search bar
    @IBOutlet var mySearchBar: UISearchBar!
    
    // outlet - table view
    @IBOutlet var myTableView: UITableView!
    
    var eventListImages: [String] = [String]()
    
    // array of event list
    var eventListName: [String] = [String]()
    var eventNameSearching: [String] = [String]()
    
    // search in progress or not
    var isSearching : Bool = false
    
    // sending images to detail event view
    var nameEvent: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventListName")
            UserDefaults.standard.synchronize()
        }
    }
    var imageEvent: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventListImage")
            UserDefaults.standard.synchronize()
        }
    }

    
    //MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reveal navigation controller
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
        // fill up data
        self.eventListImages = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo","church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
        self.eventListName  = [
            "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious", "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious","Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious"       ]
        
        // set table view delegate
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        // set search bar delegate
        self.mySearchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - table view data source and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return eventNameSearching.count
        }else {
            return eventListName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! EventListTableViewCell
        cell.eventImage.image = UIImage(named: eventListImages[indexPath.row])!
        if self.isSearching == true {
            cell.eventTitle.text = self.eventNameSearching[(indexPath as NSIndexPath).row]
        }else {
            cell.eventTitle.text = self.eventListName[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            
            
           // cell.contentView.backgroundColor = UIColor.white
            
            //cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
           // cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 15.0
        
//            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
//            cell.layer.shadowOpacity = 0.5
        //cell.layer.shadowColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        
        
    }
    
    
    
    // MARK: - UISearchBar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.mySearchBar.text!.isEmpty {
            
            // set searching false
            self.isSearching = false
            
            // reload table view
            self.myTableView.reloadData()
            
        }else{
            
            // set searghing true
            self.isSearching = true
            
            // empty searching array
            self.eventNameSearching.removeAll(keepingCapacity: false)
            
            // find matching item and add it to the searcing array
            for i in 0..<self.eventListName.count {
                
                let listItem : String = self.eventListName[i]
                if listItem.lowercased().range(of: self.mySearchBar.text!.lowercased()) != nil {
                    self.eventNameSearching.append(listItem)
                }
            }
            
            self.myTableView.reloadData()
        }
        
    }
    
    // hide kwyboard when search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.resignFirstResponder()
    }
    
    // hide keyboard when cancel button clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.text = ""
        self.mySearchBar.resignFirstResponder()
        
        self.myTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            nameEvent = eventListName [indexPath.row] as AnyObject?
            imageEvent = eventListImages [indexPath.row] as AnyObject?
            
            
        
    }
    
    //add delegate method for pushing to new detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
  
        
        }

    
    
}

