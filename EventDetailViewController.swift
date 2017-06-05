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
    
    // get data eventnamesfrom event main controller
    var labeldetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var imageDetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventImage") as AnyObject?
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         detailEventView.text = labeldetail as? String
        detailImage.image = UIImage(named: imageDetail as! String)

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
