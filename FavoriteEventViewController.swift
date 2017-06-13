//
//  FavoriteEventViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/13/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavoriteEventViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var favEventTableView: UITableView!
    
    
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
    let eventString = ["one", "two", "three", "four"]
    let eventImages = ["yougo", "yougo", "yougo","yougo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return eventImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = favEventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! FavEventTableViewCell
        myCell.eventImage.image = UIImage(named: eventImages[indexPath.row])!
        myCell.eventTitle.text = eventString[indexPath.row]
        
        return myCell
    }
    
}
