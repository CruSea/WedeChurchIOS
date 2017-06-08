//
//  EventDetailViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 5/9/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!

    @IBOutlet weak var detailEventView: UITextView!
    @IBOutlet weak var detaileventLabel: UILabel!
    
    var eventListName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var eventListImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListImage") as AnyObject?
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detaileventLabel.text = eventListName as? String
        detailImage.image = UIImage(named: eventListImage as! String)
       // detailImage.layer.cornerRadius = 20.0
        

        
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
    

}
