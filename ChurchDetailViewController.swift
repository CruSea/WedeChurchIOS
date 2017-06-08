//
//  ChurchDetailViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 5/30/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class ChurchDetailViewController: UIViewController {
    
    @IBOutlet weak var detailChurchLogo: UIImageView!
    @IBOutlet weak var detailChurchName: UILabel!
    
    // get data eventnamesfrom event main controller
    var labeldetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var imageDetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchImage") as AnyObject?
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailChurchName.text = labeldetail as? String
        detailChurchLogo.image = UIImage(named: imageDetail as! String)
        
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
