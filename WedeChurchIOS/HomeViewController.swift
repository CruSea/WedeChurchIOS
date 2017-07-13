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
        
        print(location.altitude)
        print(location.speed)
        
        self.Map.showsUserLocation = true
        manager.stopUpdatingLocation()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchResultView()
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

    func addSearchResultView(){
        
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "frequentBottomVC") as! BottomLocationVCViewController
        
        searchVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height , width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(searchVC)
        self.view.addSubview(searchVC.view)
        searchVC.didMove(toParentViewController: self)
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
