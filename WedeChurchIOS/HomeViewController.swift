//
//  HomeViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/29/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var Map: MKMapView!
    
    // location managerer declaration
    var manager = CLLocationManager()
    
    @IBAction func findMyLocation(_ sender: Any) {
        manager.startUpdatingLocation()

    }

    //finding users current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        Map.setRegion(region, animated: true)
        
//        print(location.altitude)
//        print(location.speed)
//        
        self.Map.showsUserLocation = true
        manager.stopUpdatingLocation()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding bottomsheetcontroller
        bottomView()
        
        // adding map manager
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        //slide menu of home viewcontroller
        if revealViewController() != nil {
           
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            
            
        }
        // Do any additional setup after loading the view.
    }

    func bottomView(){
        
        let bottomVC = storyboard?.instantiateViewController(withIdentifier: "frequentBottomVC") as! BottomLocationVCViewController
        
        bottomVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height , width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(bottomVC)
        self.view.addSubview(bottomVC.view)
        bottomVC.didMove(toParentViewController: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
//        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
//        
//        if(!isUserLoggedIn)
//        {
//            self.performSegue(withIdentifier: "loginView", sender: self);
//        }
        
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        
//        if UserDefaults.standard.value(forKey: "password") != nil {
//            //do something here if password exists
//            if UserDefaults.standard.value(forKey: "email") != nil{
//                username = UserDefaults.standard.value(forKey: "email") as! NSString?
//            }else{
//                username = UserDefaults.standard.value(forKey: "phone") as! NSString?
//            }
//            password = UserDefaults.standard.value(forKey: "password") as! NSString?
//            
//            if UserDefaults.standard.value(forKey: "country") != nil {
//                country = UserDefaults.standard.value(forKey: "country") as! NSString?
//            }else{
//                country = ""
//            }
//            
//            
////            if isInternetAvailable() {
////                print("internet available")
////                self.getDataFromServer()
////            }else{
////                print("internet not available")
////                self.fetchDataFromDB()
////            }
//            
//        } else {
//            //no details exists
//            self.performSegue(withIdentifier: "gotoLogin", sender: self)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
